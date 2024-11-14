import 'package:get/get.dart';
import 'package:snake_game/presentation/pages/game_over_page.dart';
import 'package:snake_game/presentation/pages/intro_page.dart';
import '../../presentation/bindings/game_binding.dart';
import '../../presentation/pages/game_page/game_page.dart';

class AppRoutes {
  static const String game = '/game';
  static const String intro = '/intro';
  static const String gameOver = '/game_over';

  static List<GetPage> routes = [
    GetPage(
      name: intro,
      page: () => const IntroPage(),
    ),
    GetPage(
      name: game,
      page: () => GamePage(),
      binding: GameBinding(),
    ),
    GetPage(
      name: gameOver,
      page: () => const GameOverPage(),
    ),
  ];
}
