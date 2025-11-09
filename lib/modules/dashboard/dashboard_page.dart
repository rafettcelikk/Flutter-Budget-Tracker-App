import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_budget_tracker_app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter_budget_tracker_app/modules/dashboard/widgets/summary_card.dart';
import 'package:flutter_budget_tracker_app/modules/dashboard/widgets/transaction_list.dart';
import 'package:flutter_budget_tracker_app/themes/app_colors.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Obx(
                      () => ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        children: [
                          SummaryCard(
                            title: "Aylık Gelir",
                            amount: controller.monthlyIncome.value,
                            icon: Icons.arrow_upward,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkIncome
                                : AppColors.income,
                            gradientColors:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkIncomeGradient
                                : AppColors.incomeGradient,
                          ),
                          SummaryCard(
                            title: "Aylık Gider",
                            amount: controller.monthlyExpense.value,
                            icon: Icons.arrow_downward,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkExpense
                                : AppColors.expense,
                            gradientColors:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkExpenseGradient
                                : AppColors.expenseGradient,
                          ),
                          SummaryCard(
                            isShowMark: true,
                            title: "Aylık Bakiye",
                            amount:
                                (controller.monthlyIncome.value -
                                controller.monthlyExpense.value),
                            icon: Icons.account_balance_wallet,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkBalance
                                : AppColors.balance,
                            gradientColors:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkBalanceGradient
                                : AppColors.balanceGradient,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 9, child: TransactionList()),
                ],
              ),
      ),
    );
  }
}
