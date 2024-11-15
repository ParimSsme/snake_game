import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';
import '../../core/enums/snake_direction.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/app_navigator.dart';
import 'package:flutter/material.dart';

class GameController extends GetxController with GetTickerProviderStateMixin {
  static GameController get to => Get.find();

  /// Score and game state variables
  RxInt playerScore = 0.obs;
  RxBool hasStarted = true.obs;

  /// Animation variables
  late Animation<double> snakeAnimation;
  late AnimationController snakeController;

  /// Snake and game field settings
  RxList<int> snake = <int>[404, 405, 406, 407].obs;
  final int noOfSquares = 500;
  final Duration snakeSpeed = Duration(milliseconds: 250);
  final int squareSize = 20;

  /// Direction and food position
  Rx<SnakeDirection> currentSnakeDirection = SnakeDirection.right.obs;
  RxInt snakeFoodPosition = 404.obs;
  final Random _random = Random();

  @override
  void onInit() {
    super.onInit();
    _setUpGame();
    _initializeAnimationController();
    startGame();
  }

  /// Set up the initial game state
  void _setUpGame() {
    playerScore.value = 0;
    currentSnakeDirection.value = SnakeDirection.right;
    _generateFoodPosition();
  }

  /// Generate a random food position
  void _generateFoodPosition() {
    do {
      snakeFoodPosition.value = _random.nextInt(noOfSquares);
    } while (snake.contains(snakeFoodPosition.value));
  }

  /// Initialize the animation controller
  void _initializeAnimationController() {
    snakeController = AnimationController(vsync: this, duration: snakeSpeed);
    snakeAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: snakeController);
    snakeController.forward();
  }

  /// Start the game timer
  void startGame() {
    Timer.periodic(snakeSpeed, (Timer timer) {
      _updateSnake();
      if(hasStarted.value) timer.cancel();
    });
  }

  /// Check if the game is over
  bool isGameOver() {
    for (int i = 0; i < snake.length - 1; i++) {
      if (snake.last == snake[i]) return true;
    }
    return false;
  }

  void toggleGame() {
    if (hasStarted.value) {
      /// Start or resume the game
      snakeController.forward();
      hasStarted.value = false;
      startGame();
    } else {
      /// Pause the game
      snakeController.stop();
      hasStarted.value = true;
    }
  }

  void onVerticalDragUpdate(DragUpdateDetails drag) {
    /// If the user swipes down and the current direction isn't 'up', set direction to 'down'
    if (drag.delta.dy > 0 && currentSnakeDirection.value != SnakeDirection.up) {
      currentSnakeDirection.value = SnakeDirection.down;
    }
    /// If the user swipes up and the current direction isn't 'down', set direction to 'up'
    else if (drag.delta.dy < 0 && currentSnakeDirection.value != SnakeDirection.down) {
      currentSnakeDirection.value = SnakeDirection.up;
    }
  }

  void onHorizontalDragUpdate(DragUpdateDetails drag) {
    /// If the user swipes right and the current direction isn't 'left', set direction to 'right'
    if (drag.delta.dx > 0 && currentSnakeDirection.value != SnakeDirection.left) {
      currentSnakeDirection.value = SnakeDirection.right;
    }
    /// If the user swipes left and the current direction isn't 'right', set direction to 'left'
    else if (drag.delta.dx < 0 && currentSnakeDirection.value != SnakeDirection.right) {
      currentSnakeDirection.value = SnakeDirection.left;
    }
  }

  void onBackClicked() => Get.offNamed(AppRoutes.intro);

  /// Update the snake's position
  void _updateSnake() {
    if (hasStarted.value) return;

    playerScore.value = (snake.length - 4) * 100;

    /// Update the snake's movement direction
    _moveSnake();

    /// Check for food and grow snake or remove tail
    if (snake.last == snakeFoodPosition.value) {
      _generateFoodPosition();
    } else {
      snake.removeAt(0);
    }

    snake.refresh();

    /// Handle game over state
    if (isGameOver()) {
      hasStarted.value = false;
      _navigateToGameOver();
    }
  }

  /// Move the snake in the current direction
  void _moveSnake() {
    switch (currentSnakeDirection.value) {
      case SnakeDirection.down:
        snake.add(snake.last > noOfSquares
            ? snake.last + squareSize - (noOfSquares + squareSize)
            : snake.last + squareSize);
        break;
      case SnakeDirection.up:
        snake.add(snake.last < squareSize
            ? snake.last - squareSize + (noOfSquares + squareSize)
            : snake.last - squareSize);
        break;
      case SnakeDirection.right:
        snake.add((snake.last + 1) % squareSize == 0
            ? snake.last + 1 - squareSize
            : snake.last + 1);
        break;
      case SnakeDirection.left:
        snake.add(snake.last % squareSize == 0
            ? snake.last - 1 + squareSize
            : snake.last - 1);
        break;
    }
  }

  /// Navigate to the Game Over screen
  void _navigateToGameOver() {
    AppNavigator.to.navigateToGameOver(score: playerScore.value);
  }

  /// Update the snake's direction based on user input
  void updateDirection(SnakeDirection direction) {
    if ((direction == SnakeDirection.down && currentSnakeDirection.value != SnakeDirection.up) ||
        (direction == SnakeDirection.up && currentSnakeDirection.value != SnakeDirection.down) ||
        (direction == SnakeDirection.right && currentSnakeDirection.value != SnakeDirection.left) ||
        (direction == SnakeDirection.left && currentSnakeDirection.value != SnakeDirection.right)) {
      currentSnakeDirection.value = direction;
    }
  }

  @override
  void onClose() {
    /// Dispose the animation controller
    snakeController.dispose();
    super.onClose();
  }
}

