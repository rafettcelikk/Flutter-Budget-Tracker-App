import 'package:flutter_budget_tracker_app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter_budget_tracker_app/modules/home/home_controller.dart';
import 'package:flutter_budget_tracker_app/modules/profile/profile_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
