import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:snake_game/core/assets/app_image_assets.dart';
import 'package:snake_game/presentation/controllers/game_controller.dart';
import '../../../../core/enums/snake_direction.dart';
import '../../../../core/theme/app_colors.dart';

class GridCell extends StatelessWidget {
  final int index;
  const GridCell({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = GameController.to;

    return Container(
      margin: EdgeInsets.all(controller.snake.contains(index) ? 0 : 0.5),
      decoration: BoxDecoration(
        color: AppColors.gameCellColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Obx(
        () => index == controller.snakeFoodPosition.value
            ? Image.asset(AppImageAssets.food)
            : index == controller.snake.last
                ? SnakeHead(
                    direction: controller.currentSnakeDirection.value,
                  )
                : index == controller.snake.first
                    ? SnakeTail(
                        direction: controller.currentSnakeDirection.value)
                    : controller.snake.contains(index)
                        ? Image.asset(AppImageAssets.snakeBody)
                        : const SizedBox.shrink(),
      ),
    );
  }
}

class SnakeHead extends StatelessWidget {
  final SnakeDirection direction;

  const SnakeHead({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    double angle;
    switch (direction) {
      case SnakeDirection.left:
        angle = -pi / 2; // Rotate 90° counter-clockwise
        break;
      case SnakeDirection.right:
        angle = pi / 2; // Rotate 90° clockwise
        break;
      case SnakeDirection.down:
        angle = pi; // Rotate 180°
        break;
      case SnakeDirection.up:
      default:
        angle = 0; // No rotation for right
    }

    return Transform.rotate(
      angle: angle,
      child: Image.asset(
        AppImageAssets
            .snakeHead, // Add the image file to your assets folder and reference here
        width: 50, // Set the desired size
        height: 50,
      ),
    );
  }
}

class SnakeTail extends StatelessWidget {
  final SnakeDirection direction;

  const SnakeTail({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    double angle;
    switch (direction) {
      case SnakeDirection.left:
        angle = -pi / 2; // Rotate 90° counter-clockwise
        break;
      case SnakeDirection.right:
        angle = pi / 2; // Rotate 90° clockwise
        break;
      case SnakeDirection.down:
        angle = pi; // Rotate 180°
        break;
      case SnakeDirection.up:
      default:
        angle = 0; // No rotation for right
    }

    return Transform.rotate(
      angle: angle,
      child: Image.asset(
        AppImageAssets
            .snakeTail, // Add the image file to your assets folder and reference here
        width: 50, // Set the desired size
        height: 50,
      ),
    );
  }
}
