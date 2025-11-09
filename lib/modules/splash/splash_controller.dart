import 'package:flutter_budget_tracker_app/core/base_controller.dart';
import 'package:flutter_budget_tracker_app/routes/app_pages.dart';
import 'package:flutter_budget_tracker_app/services/api_service.dart';
import 'package:flutter_budget_tracker_app/services/auth_service.dart';
import 'package:flutter_budget_tracker_app/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class SplashController extends BaseController {
  // final areServicesReady = false.obs;
  @override
  void onReady() async {
    super.onReady();
    await waitForServices();
    // areServicesReady.value = true;
    await checkTokenAndRedirect();
  }

  Future<void> waitForServices() async {
    while (!Get.isRegistered<StorageService>() ||
        !Get.isRegistered<ApiService>() ||
        !Get.isRegistered<AuthService>()) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Future<void> checkTokenAndRedirect() async {
    final _authService = Get.find<AuthService>();
    final isAuthenticated = await _authService.isAuthenticated();
    if (isAuthenticated) {
      Get.offAllNamed(AppRoutes.HOME);
    } else {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}
