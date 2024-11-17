import 'package:flutter/material.dart';

class AppAnimatedIconButton extends StatelessWidget {
  final AnimatedIconData icon;
  final bool isEnabled;
  final VoidCallback onPressed;
  final Animation<double> progress;
  const AppAnimatedIconButton({
    super.key,
    required this.icon,
    required this.isEnabled,
    required this.onPressed,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isEnabled ? onPressed : null,
      icon: AnimatedIcon(
        icon: icon,
        size: 30.0,
        color: isEnabled ? Colors.white : Colors.white24,
        progress: progress,
      ),
    );
  }
}
