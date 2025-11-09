import 'package:flutter_budget_tracker_app/core/base_controller.dart';
import 'package:flutter_budget_tracker_app/routes/app_pages.dart';
import 'package:flutter_budget_tracker_app/services/auth_service.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  late final AuthService _authService;

  @override
  void onInit() {
    super.onInit();
    _authService = Get.find<AuthService>();
  }

  loginWithGoogle() async {
    final user = await _authService.signInWithGoogle();
    if (user != null) {
      Get.offAllNamed(AppRoutes.HOME);
    }
  }
}
