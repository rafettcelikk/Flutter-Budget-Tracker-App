import 'package:flutter/cupertino.dart';
import 'package:flutter_budget_tracker_app/core/base_controller.dart';
import 'package:flutter_budget_tracker_app/models/app_category.dart';
import 'package:flutter_budget_tracker_app/models/transaction_params.dart';
import 'package:flutter_budget_tracker_app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter_budget_tracker_app/repositories/category_repository.dart';
import 'package:flutter_budget_tracker_app/repositories/transaction_repository.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class TransactionController extends BaseController {
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();
  final TransactionRepository _transactionRepository =
      Get.find<TransactionRepository>();

  final categories = <AppCategory>[].obs;
  final selectedCategoryId = "".obs;
  final transactionType = "expense".obs;
  final formKey = GlobalKey<FormState>();
  final amount = 0.0.obs;
  final description = "".obs;
  final date = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();

    ever(transactionType, (callback) {
      getFirstCategory();
    });
  }

  Future createTransaction() async {
    setLoading(true);
    try {
      if (!formKey.currentState!.validate()) return null;
      final transaction = Transaction(
        id: "",
        amount: amount.value,
        categoryId: selectedCategoryId.value,
        description: description.value,
        date: date.value,
        type: transactionType.value,
        userId: "",
      );
      var result = await _transactionRepository.createTransaction(transaction);
      if (result != null) {
        await Get.find<DashboardController>().refreshDashboard();
        Get.back();
        showSuccessSnackbar(message: "İşlem başarıyla oluşturuldu.");
        clearForm();
      }
    } catch (e) {
      showErrorSnackbar(
        message: "İşlem oluşturulurken bir hata oluştu.",
        duration: Duration(seconds: 1),
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadCategories() async {
    setLoading(true);
    try {
      final result = await _categoryRepository.getCategories();
      categories.value = result;
      getFirstCategory();
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  void getFirstCategory() {
    final filteredCategories = categories
        .where((cat) => cat.type == transactionType.value)
        .toList();
    if (filteredCategories.isNotEmpty) {
      selectedCategoryId.value = filteredCategories.first.id!;
    } else {
      selectedCategoryId.value = "";
    }
  }

  void clearForm() {
    amount.value = 0.0;
    description.value = "";
    date.value = DateTime.now();
    transactionType.value = "expense";
    selectedCategoryId.value = "";
  }
}
