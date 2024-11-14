import 'package:flutter/material.dart';
import 'package:snake_game/core/assets/app_image_assets.dart';
import 'package:get/get.dart';
import '../../core/theme/app_text_styles.dart';
import '../controllers/intro_controller.dart';

class IntroPage extends GetView<IntroController> {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Image.asset(AppImageAssets.snake, height: 240),

              const SizedBox(height: 20.0),

              const Text(
                'Snake Game',
                style: AppTextStyles.titleLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50.0),

              TextButton(
                onPressed: controller.startGame,
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
