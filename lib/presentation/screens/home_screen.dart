import 'package:flutter/material.dart';
import 'package:mulmuger/presentation/widgets/water_bottle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: WaterBottle(percentage: 1))],
      ),
    );
  }
}
