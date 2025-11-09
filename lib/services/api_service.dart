import 'package:dio/dio.dart';
import 'package:flutter_budget_tracker_app/services/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class ApiConstants {
  static const String baseUrl = "https://gelir-gider-backend.onrender.com/api";
  static const String login = "/auth/google";
  static const String profile = "/auth/profile";
  static const String categories = "/categories";
  static const String transactions = "/transactions";
  static String serverClientId = dotenv.env["SERVER_CLIENT_ID"] ?? "";
}

class ApiService extends GetxService {
  late StorageService _storageService;
  late Dio _dio;

  Future<ApiService> init() async {
    _storageService = Get.find<StorageService>();
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(seconds: 60), // Bağlantı zaman aşımı
        receiveTimeout: Duration(seconds: 60), // Alım zaman aşımı
        contentType: "application/json",
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = _storageService.getValue<String>(StorageKeys.userToken);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Yetkilendirme hatası durumunda yapılacak işlemler
            print(
              "Yetkilendirme hatası: Kullanıcı oturumu sona ermiş olabilir.",
            );
            await _storageService.remove(StorageKeys.userToken);
            // Gerekirse kullanıcıyı giriş ekranına yönlendirin
          }
          return handler.next(error);
        },
      ),
    );
    return this;
  }

  Future<Response> getRequest(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("GET isteği sırasında hata oluştu: $e");
      rethrow;
    }
  }

  Future<Response> postRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("POST isteği sırasında hata oluştu: $e");
      rethrow;
    }
  }

  Future<Response> putRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("PUT isteği sırasında hata oluştu: $e");
      rethrow;
    }
  }

  Future<Response> deleteRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      print("DELETE isteği sırasında hata oluştu: $e");
      rethrow;
    }
  }
}
