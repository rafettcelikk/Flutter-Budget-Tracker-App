import 'package:flutter/material.dart';
import 'package:flutter_budget_tracker_app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter_budget_tracker_app/themes/app_colors.dart';
import 'package:flutter_budget_tracker_app/utils/icon_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionList extends GetView<DashboardController> {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.myTransactions.isEmpty) {
        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 48,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkTiffanyBlue.withAlpha(128)
                        : AppColors.tiffanyBlue.withAlpha(128),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Henüz kayıtlı bir transaction yok",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Card(
        shape: BeveledRectangleBorder(),
        child: ListView.separated(
          itemBuilder: (context, index) {
            var transaction = controller.myTransactions[index];
            var category = transaction.category;
            return Dismissible(
              key: ValueKey(transaction.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                controller.deleteTransaction(transaction.id!);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? (transaction.type == "income")
                              ? AppColors.darkIncome.withAlpha(32)
                              : AppColors.darkExpense.withAlpha(32)
                        : (transaction.type == "income")
                        ? AppColors.income.withAlpha(32)
                        : AppColors.expense.withAlpha(32),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    getCategoryIcon(
                      iconName: category!.icon!,
                      isSystem: true,
                      type: category.type!,
                    ),
                    color: transaction.type == "income"
                        ? (Theme.of(context).brightness == Brightness.dark)
                              ? AppColors.darkIncome
                              : AppColors.income
                        : (Theme.of(context).brightness == Brightness.dark)
                        ? AppColors.darkExpense
                        : AppColors.expense,
                  ),
                ),
                trailing: Column(
                  children: [
                    Text(
                      "${transaction.type == "income" ? "+" : "-"} ${NumberFormat.currency(symbol: "₺", decimalDigits: 2).format(double.parse(transaction.amount!))}",
                      style: TextStyle(
                        color: transaction.type == "income"
                            ? (Theme.of(context).brightness == Brightness.dark)
                                  ? AppColors.darkIncome
                                  : AppColors.income
                            : (Theme.of(context).brightness == Brightness.dark)
                            ? AppColors.darkExpense
                            : AppColors.expense,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat("dd-MM-yyyy").format(transaction.date!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                title: Text(category!.name!),
                subtitle: Text(transaction.description!),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 1);
          },
          itemCount: controller.myTransactions.length,
        ),
      );
    });
  }
}
