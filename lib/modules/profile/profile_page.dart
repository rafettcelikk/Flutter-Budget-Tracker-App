import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_budget_tracker_app/modules/profile/profile_controller.dart';
import 'package:flutter_budget_tracker_app/modules/profile/widgets/info_card.dart';
import 'package:flutter_budget_tracker_app/services/theme_service.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                controller.user.value?.profilePhoto ?? "",
              ),
            ),
            SizedBox(height: 24),
            InfoCard(
              title: "Adı",
              value: controller.user.value?.firstName ?? "",
            ),
            InfoCard(
              title: "Soyadı",
              value: controller.user.value?.lastName ?? "",
            ),
            InfoCard(
              title: "E-posta",
              value: controller.user.value?.email ?? "",
            ),
            SettingsCard(),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  SettingsCard({super.key});
  final ThemeService _themeService = Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.brightness_6),
        title: Text("Tema"),
        trailing: Obx(
          () => Switch(
            value: _themeService.isDarkMode,
            onChanged: (value) {
              _themeService.toggleTheme();
            },
          ),
        ),
      ),
    );
  }
}
