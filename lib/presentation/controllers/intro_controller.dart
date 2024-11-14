import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../core/utils/app_navigator.dart';

class IntroController extends GetxController {
  void startGame() {
    AppNavigator.to.navigateToGame();
  }
}