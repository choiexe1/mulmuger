import 'package:flutter/material.dart';
import 'package:mulmuger/presentation/screens/components/ads_banner.dart';
import 'package:mulmuger/presentation/screens/components/animated_button.dart';
import 'package:mulmuger/presentation/screens/components/step_slider.dart';
import 'package:mulmuger/presentation/screens/home/home_action.dart';
import 'package:mulmuger/presentation/screens/home/home_state.dart';
import 'package:mulmuger/presentation/screens/home/widgets/water_bottle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.adsId,
    required this.onAction,
    required this.state,
    super.key,
  });

  final HomeState state;
  final String adsId;
  final ValueChanged<HomeAction> onAction;

  void _onChangeDuration(double value) {
    if (value <= 0) {
      onAction(const HomeAction.deleteNotifications());
    } else {
      onAction(HomeAction.onChangedDuration(Duration(minutes: value.toInt())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              Center(child: WaterBottle(percentage: state.water)),
              const Row(
                spacing: 8,
                children: [Icon(Icons.timer_outlined), Text('알림 설정')],
              ),
              StepSlider(
                max: 60,
                interval: 5,
                labelSuffix: '분',
                value: state.duration.inMinutes.toDouble(),
                padding: 8,
                onChangedEnd: _onChangeDuration,
              ),
              Row(
                spacing: 8,
                children: [
                  AnimatedButton(
                    text: const Text('예약된 알림'),
                    onTap: () =>
                        onAction(const HomeAction.checkNotifications()),
                  ),
                  AnimatedButton(
                    text: const Text('알림 제거'),
                    onTap: () =>
                        onAction(const HomeAction.deleteNotifications()),
                  ),
                  AnimatedButton(
                    text: const Text('물병 비우기'),
                    onTap: () => onAction(const HomeAction.clearWater()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: AdsBanner(adsId: adsId),
      ),
    );
  }
}
