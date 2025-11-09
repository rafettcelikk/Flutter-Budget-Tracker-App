import 'package:flutter_budget_tracker_app/core/base_controller.dart';
import 'package:flutter_budget_tracker_app/routes/app_pages.dart';
import 'package:flutter_budget_tracker_app/services/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final currentIndex = 0.obs;

  changeIndex(int index) {
    currentIndex.value = index;
  }

  logout() async {
    await Get.find<AuthService>().signOut();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  void goToTransaction() {
    Get.toNamed(AppRoutes.TRANSACTION);
  }
}
