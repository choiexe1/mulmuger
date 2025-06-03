import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({required this.text, required this.onTap, super.key});

  final Text text;
  final VoidCallback onTap;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;

  void togglePressed() => setState(() {
    _isPressed = !_isPressed;
  });

  @override
  Widget build(BuildContext context) {
    final scale = _isPressed ? 0.90 : 1.0;

    return GestureDetector(
      onTapCancel: togglePressed,
      onTapDown: (_) => togglePressed(),
      onTapUp: (_) {
        togglePressed();
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        padding: const EdgeInsets.all(8),
        transform: Matrix4.identity()..scale(scale),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(),
        ),
        child: widget.text,
      ),
    );
  }
}
