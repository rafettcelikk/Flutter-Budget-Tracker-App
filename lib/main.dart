import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 🌿 dotenv'i ekle
import 'package:flutter_budget_tracker_app/core/app_bindings.dart';
import 'package:flutter_budget_tracker_app/routes/app_pages.dart';
import 'package:flutter_budget_tracker_app/themes/app_theme.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Gelir Gider Takip Uygulaması',
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.INITIAL,
      initialBinding: AppBindings(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
