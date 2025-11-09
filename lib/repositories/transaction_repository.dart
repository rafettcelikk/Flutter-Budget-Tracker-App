import 'package:flutter_budget_tracker_app/models/app_transaction.dart';
import 'package:flutter_budget_tracker_app/models/transaction_params.dart';
import 'package:flutter_budget_tracker_app/services/api_service.dart';
import 'package:get/get.dart';

class TransactionRepository extends GetxService {
  late final ApiService _apiService;
  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  Future<List<AppTransaction>> getTransactions() async {
    try {
      final response = await _apiService.getRequest(ApiConstants.transactions);
      if (response.statusCode == 200) {
        var data = response.data["transactions"] as List;
        return data.map((tx) => AppTransaction.fromJson(tx)).toList();
      }
    } catch (e) {
      print(e);
    }
    throw Exception("Transactionlar getirilirken bir hata oluştu.");
  }

  Future<AppTransaction> createTransaction(Transaction transaction) async {
    try {
      final response = await _apiService.postRequest(
        ApiConstants.transactions,
        data: transaction.toJson(),
      );
      if (response.statusCode == 201) {
        return AppTransaction.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    throw Exception("Transaction oluşturulurken bir hata oluştu.");
  }

  Future<bool> deleteTransaction(String id) async {
    try {
      final response = await _apiService.deleteRequest(
        '${ApiConstants.transactions}/$id',
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    throw Exception("Transaction silinirken bir hata oluştu.");
  }
}
