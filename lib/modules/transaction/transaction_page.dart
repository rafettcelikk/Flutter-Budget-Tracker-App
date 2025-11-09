import 'package:flutter/material.dart';
import 'package:flutter_budget_tracker_app/models/app_category.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/controllers/transaction_controller.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/widgets/add_category_dialog.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/widgets/amount_input.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/widgets/category_dropdown.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/widgets/date_input.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/widgets/description_input.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/widgets/save_button.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/widgets/transaction_type_selector.dart';
import 'package:flutter_budget_tracker_app/themes/app_colors.dart';
import 'package:get/get.dart';

class TransactionPage extends GetView<TransactionController> {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İşlemler")),
      body: Obx(
        () => controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TransactionTypeSelector(),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: CategoryDropdown()),
                          IconButton(
                            onPressed: () async {
                              final category = await Get.dialog<AppCategory>(
                                AddCategoryDialog(),
                              );
                              if (category != null) {
                                await controller.loadCategories();
                                controller.selectedCategoryId.value =
                                    category.id!;
                              }
                            },
                            icon: Icon(Icons.add_circle_outline),
                            color: AppColors.darkTiffanyBlue,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      AmountInput(),
                      SizedBox(height: 16),
                      DescriptionInput(),
                      SizedBox(height: 16),
                      DateInput(),
                      SizedBox(height: 16),
                      SaveButton(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
