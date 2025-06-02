import 'package:flutter/material.dart';

class WaterBottle extends StatelessWidget {
  const WaterBottle({
    required this.percentage,
    super.key,
    this.imageUrl = 'assets/images/water_bottle.png',
  });

  static const double limit = 0.77;
  static const int innerHeight = 152;

  final String imageUrl;
  final double percentage;

  bool get _isOverflow => percentage > limit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 195,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 30,
            child: ClipRRect(
              borderRadius: _isOverflow
                  ? const BorderRadius.vertical(top: Radius.circular(24))
                  : const BorderRadius.vertical(top: Radius.circular(2)),
              child: Container(
                width: 56,
                height: _isOverflow
                    ? innerHeight * limit
                    : innerHeight * percentage,
                color: Colors.blue.withValues(alpha: 0.7),
              ),
            ),
          ),
          Image.asset(imageUrl, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
