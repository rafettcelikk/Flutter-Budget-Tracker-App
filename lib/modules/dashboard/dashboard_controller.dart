import 'package:flutter/widgets.dart';
import 'package:flutter_budget_tracker_app/core/base_controller.dart';
import 'package:flutter_budget_tracker_app/models/app_transaction.dart';
import 'package:flutter_budget_tracker_app/repositories/transaction_repository.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  late final TransactionRepository _transactionRepository;
  final monthlyIncome = 0.0.obs;
  final monthlyExpense = 0.0.obs;

  void calculateMonthlySummary() {
    monthlyIncome.value = 0.0;
    monthlyExpense.value = 0.0;
    final now = DateTime.now();
    final nowYear = now.year;
    final nowMonth = now.month;

    if (myTransactions.isNotEmpty) {
      var filteredTransactions = myTransactions
          .where(
            (transaction) =>
                transaction.date!.year == nowYear &&
                transaction.date!.month == nowMonth,
          )
          .toList();
      for (var transaction in filteredTransactions) {
        if (transaction.type == "income") {
          monthlyIncome.value += double.parse(transaction.amount!);
        } else {
          monthlyExpense.value += double.parse(transaction.amount!);
        }
      }
    } else {
      monthlyIncome.value = 0.0;
      monthlyExpense.value = 0.0;
    }
    debugPrint(
      "Aylık Gelir: ${monthlyIncome.value}, Aylık Gider: ${monthlyExpense.value}",
    );
  }

  @override
  void onInit() async {
    super.onInit();
    _transactionRepository = Get.find<TransactionRepository>();
    await getTransactions();
  }

  Future<void> refreshDashboard() async {
    await getTransactions();
  }

  final myTransactions = <AppTransaction>[].obs;

  Future getTransactions() async {
    setLoading(true);
    try {
      final transactions = await _transactionRepository.getTransactions();
      myTransactions.value = transactions;
      calculateMonthlySummary();
    } catch (e) {
      print(e);
      showErrorSnackbar(message: "İşlemler getirilirken bir hata oluştu.");
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteTransaction(String id) async {
    // setLoading(true);
    try {
      await _transactionRepository.deleteTransaction(id);
      myTransactions.removeWhere((transaction) => transaction.id == id);
      calculateMonthlySummary();
      showSuccessSnackbar(message: "İşlem başarıyla silindi.");
    } catch (e) {
      showErrorSnackbar(message: "İşlem silinirken bir hata oluştu.");
    } finally {
      // setLoading(false);
    }
  }
}
