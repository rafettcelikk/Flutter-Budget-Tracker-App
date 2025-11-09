import 'package:flutter/material.dart';
import 'package:flutter_budget_tracker_app/modules/login/login_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await controller.loginWithGoogle();
          },
          child: const Text("Google ile Giriş Yap"),
        ),
      ),
    );
  }
}
