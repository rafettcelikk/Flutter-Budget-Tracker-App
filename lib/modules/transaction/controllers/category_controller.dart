import 'package:flutter/material.dart';
import 'package:flutter_budget_tracker_app/core/base_controller.dart';
import 'package:flutter_budget_tracker_app/models/app_category.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/controllers/transaction_controller.dart';
import 'package:flutter_budget_tracker_app/repositories/category_repository.dart';
import 'package:flutter_budget_tracker_app/utils/icon_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/instance_manager.dart';

class CategoryController extends BaseController {
  final categoryName = "".obs;
  final selectedIcon = "".obs;
  final formKey = GlobalKey<FormState>();
  final categoryType = "".obs;
  late final CategoryRepository _categoryRepository;

  @override
  void onInit() {
    super.onInit();
    _categoryRepository = Get.find<CategoryRepository>();
    categoryType.value =
        Get.find<TransactionController>().transactionType.value;
    selectedIcon.value = icons.first;
  }

  Future<void> createCategory() async {
    try {
      if (!formKey.currentState!.validate()) return;
      setLoading(true);
      var newCategory = AppCategory(
        name: categoryName.value,
        icon: selectedIcon.value,
        type: categoryType.value,
      );
      var addedCategory = await _categoryRepository.createCategory(newCategory);
      Get.back(result: addedCategory);
    } catch (e) {
      showErrorSnackbar(
        message: "Kategori oluşturulurken bir hata oluştu." + e.toString(),
      );
    } finally {
      setLoading(false);
    }
  }
}
