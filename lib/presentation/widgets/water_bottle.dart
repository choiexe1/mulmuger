import 'package:flutter/material.dart';

class WaterBottle extends StatelessWidget {
  static const double limit = 0.78;
  static const int innerHeight = 152;

  final String imageUrl;
  final double percentage;
  final String packageName;

  const WaterBottle({
    super.key,
    required this.percentage,
    this.imageUrl = 'assets/images/water_bottle.png',
    this.packageName = 'mulmuger',
  });

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
                  ? BorderRadius.vertical(top: Radius.circular(24))
                  : BorderRadius.vertical(top: Radius.circular(2)),
              child: Container(
                width: 56,
                height: _isOverflow
                    ? innerHeight * limit
                    : innerHeight * percentage,
                color: Colors.blue.withValues(alpha: 0.7),
              ),
            ),
          ),
          Image.asset(imageUrl, fit: BoxFit.contain, package: packageName),
        ],
      ),
    );
  }
}
