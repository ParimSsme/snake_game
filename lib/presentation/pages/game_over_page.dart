import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_game/core/theme/app_text_styles.dart';
import 'package:snake_game/core/utils/app_navigator.dart';
import '../../core/theme/app_colors.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int score = Get.arguments;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Text(
                'Game Over',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  style: AppTextStyles.titleMedium,
                  text: 'Your Score is:  ', // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: score.toString(), style: AppTextStyles.score),
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  AppNavigator.to.navigateToGame();
                },
                child: const Text("Try Again"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
