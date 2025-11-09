import 'package:flutter_budget_tracker_app/modules/login/login_controller.dart';
import 'package:get/instance_manager.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
