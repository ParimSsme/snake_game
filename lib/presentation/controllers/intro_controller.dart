import 'package:get/get.dart';
import '../../core/utils/app_navigator.dart';

class IntroController extends GetxController {
  static IntroController get to => Get.find();

  void startGame() {
    AppNavigator.to.navigateToGame();
  }
}