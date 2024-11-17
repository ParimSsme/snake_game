import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake_game/core/assets/app_image_assets.dart';
import '../../../../core/enums/snake_direction.dart';
import '../../../../core/theme/app_colors.dart';

class GameCell extends StatelessWidget {
  final int index;
  final bool isSnakeBody;
  final bool isSnakeHead;
  final bool isSnakeFood;
  final SnakeDirection snakeDirection;

  const GameCell({
    Key? key,
    required this.index,
    required this.isSnakeBody,
    required this.isSnakeHead,
    required this.isSnakeFood,
    required this.snakeDirection,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(isSnakeBody ? 0 : 0.5),
      decoration: BoxDecoration(
        color: AppColors.gameCellColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: _buildCellContent(),
    );
  }

  Widget _buildCellContent() {
    if (isSnakeFood) {
      return Image.asset(AppImageAssets.food);
    } else if (isSnakeHead) {
      return _SnakeHead(direction: snakeDirection);
    } else if (isSnakeBody) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(AppImageAssets.snakeBody),
      );
    }
    return const SizedBox.shrink();
  }
}

class _SnakeHead extends StatelessWidget {
  final SnakeDirection direction;

  const _SnakeHead({required this.direction});

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
