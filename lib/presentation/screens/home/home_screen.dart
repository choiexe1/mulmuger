import 'package:flutter/material.dart';
import 'package:mulmuger/presentation/screens/components/ads_banner.dart';
import 'package:mulmuger/presentation/screens/components/animated_button.dart';
import 'package:mulmuger/presentation/screens/components/app_dialog.dart';
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
                    onTap: () {
                      onAction(const HomeAction.checkNotifications());

                      showGeneralDialog(
                        barrierLabel: 'Label',
                        barrierDismissible: true,
                        barrierColor: Colors.black.withValues(alpha: 0.5),
                        transitionDuration: const Duration(milliseconds: 300),
                        context: context,
                        pageBuilder: (context, anim1, anim2) {
                          return AppDialog(
                            iconBackgroundColor: Colors.blueAccent,
                            title: const Text(
                              '예약된 알림',
                              style: TextStyle(color: Colors.black),
                            ),
                            message: Text(
                              state.message,
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.6),
                                fontSize: 12,
                              ),
                            ),
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            showCloseButton: true,
                          );
                        },
                        transitionBuilder: (context, anim1, anim2, child) {
                          return SlideTransition(
                            position: Tween(
                              begin: const Offset(0, -1),
                              end: const Offset(0, -0.4),
                            ).animate(anim1),
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                  AnimatedButton(
                    text: const Text('알림 제거'),
                    onTap: () {
                      onAction(const HomeAction.deleteNotifications());

                      showGeneralDialog(
                        barrierLabel: 'Label',
                        barrierDismissible: true,
                        barrierColor: Colors.black.withValues(alpha: 0.5),
                        transitionDuration: const Duration(milliseconds: 300),
                        context: context,
                        pageBuilder: (context, anim1, anim2) {
                          return AppDialog(
                            iconBackgroundColor: Colors.redAccent,
                            title: const Text(
                              '알림 제거',
                              style: TextStyle(color: Colors.black),
                            ),
                            message: Text(
                              '알람이 제거됐어요!',
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.6),
                                fontSize: 12,
                              ),
                            ),
                            icon: const Icon(
                              Icons.close_sharp,
                              color: Colors.white,
                            ),
                            showCloseButton: true,
                          );
                        },
                        transitionBuilder: (context, anim1, anim2, child) {
                          return SlideTransition(
                            position: Tween(
                              begin: const Offset(0, -1),
                              end: const Offset(0, -0.4),
                            ).animate(anim1),
                            child: child,
                          );
                        },
                      );
                    },
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
