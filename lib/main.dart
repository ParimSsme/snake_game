import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_navigator.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AppNavigator());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.intro,
      defaultTransition: Transition.circularReveal,
      getPages: AppRoutes.routes,
    );
  }
}