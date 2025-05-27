import 'package:flutter/material.dart';
import 'package:mulmuger/config/app_config.dart';
import 'package:mulmuger/presentation/screens/home_action.dart';
import 'package:mulmuger/presentation/widgets/step_slider.dart';
import 'package:mulmuger/presentation/widgets/water_bottle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.onAction, super.key});

  final ValueChanged<HomeAction> onAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.instance.appName),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              const Center(child: WaterBottle(percentage: 1)),
              const Row(
                spacing: 8,
                children: [Icon(Icons.timer_outlined), Text('알림 설정')],
              ),
              StepSlider(
                max: 60,
                interval: 5,
                min: 5,
                labelSuffix: '분',
                padding: 8,
                value: 5,
                onChangedEnd: (double value) {
                  onAction(
                    HomeAction.onChangedDuration(
                      Duration(minutes: value.toInt()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
