import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_game/presentation/controllers/game_controller.dart';
import 'package:snake_game/presentation/pages/game_page/widgets/game_cell.dart';
import '../../../core/widgets/app_animated_icon_button.dart';

class GamePage extends GetView<GameController> {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Score: ${controller.playerScore.value}',
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),

          /// Back button
          child: IconButton(
            onPressed: controller.onBackClicked,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),

        actions: [
          ///  Play/Pause game button
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Obx(
              () => AppAnimatedIconButton(
                onPressed: () {
                  controller.toggleGame();
                },
                progress: controller.snakeAnimation,
                isEnabled: true,
                icon: controller.hasStarted.value
                    ? AnimatedIcons.pause_play
                    : AnimatedIcons.play_pause,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onVerticalDragUpdate: controller.onVerticalDragUpdate,
          onHorizontalDragUpdate: controller.onHorizontalDragUpdate,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              itemCount: controller.noOfSquares,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.squareSize,
              ),
              itemBuilder: (context, index) {

                return Obx(
                  () => GameCell(
                    index: index,
                    isSnakeBody: controller.snake.contains(index),
                    isSnakeHead: index == controller.snake.last,
                    isSnakeFood: index == controller.snakeFoodPosition.value,
                    snakeDirection: controller.currentSnakeDirection.value,
                  ),
                );

              },
            ),
          ),
        ),
      ),
    );
  }
}
