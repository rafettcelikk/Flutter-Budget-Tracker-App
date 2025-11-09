import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_tracker_app/modules/dashboard/dashboard_page.dart';
import 'package:flutter_budget_tracker_app/modules/home/home_controller.dart';
import 'package:flutter_budget_tracker_app/modules/profile/profile_page.dart';
import 'package:flutter_budget_tracker_app/themes/app_colors.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gelir Gider Takip Uygulaması"),
        actions: [
          IconButton(onPressed: controller.logout, icon: Icon(Icons.logout)),
        ],
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [DashboardPage(), ProfilePage()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToTransaction,
        backgroundColor: AppColors.darkHotPink,
        shape: CircleBorder(),
        child: Icon(Icons.add_rounded, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar(
          gapLocation: GapLocation.center,
          backgroundColor: AppColors.darkTiffanyBlue,
          activeColor: Colors.white,
          splashColor: Colors.white,
          inactiveColor: Colors.white.withAlpha(100),
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          notchSmoothness: NotchSmoothness.softEdge,
          icons: [Icons.dashboard_outlined, Icons.person],
          activeIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
        ),
      ),
    );
  }
}
