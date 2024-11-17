import 'dart:async';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class AppNavigator {
  static AppNavigator get to => Get.find();

  Future? navigateToIntro() => Get.toNamed(AppRoutes.intro);

  Future? navigateToGame() => Get.toNamed(AppRoutes.game);

  Future? navigateToGameOver({
    required int score,
  }) =>
      Get.offAndToNamed(AppRoutes.gameOver, arguments: score);

}
