import 'package:flutter_budget_tracker_app/modules/transaction/controllers/transaction_controller.dart';
import 'package:get/instance_manager.dart';

class TransactionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionController());
  }
}
