import 'package:flutter_budget_tracker_app/models/app_category.dart';
import 'package:flutter_budget_tracker_app/services/api_service.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxService {
  late final ApiService _apiService;
  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  Future<List<AppCategory>> getCategories() async {
    try {
      final response = await _apiService.getRequest(ApiConstants.categories);
      if (response.statusCode == 200) {
        var data = response.data as List;
        return data.map((category) => AppCategory.fromJson(category)).toList();
      }
    } catch (e) {
      print(e);
    }
    throw Exception("Kategoriler getirilirken bir hata oluştu.");
  }

  Future<AppCategory> createCategory(AppCategory category) async {
    try {
      final response = await _apiService.postRequest(
        ApiConstants.categories,
        data: category.toJson(),
      );
      if (response.statusCode == 201) {
        return AppCategory.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    throw Exception("Kategori oluşturulurken bir hata oluştu.");
  }
}
