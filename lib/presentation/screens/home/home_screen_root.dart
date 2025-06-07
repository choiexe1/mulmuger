import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:mulmuger/presentation/screens/home/home_action.dart';
import 'package:mulmuger/presentation/screens/home/home_screen.dart';
import 'package:mulmuger/presentation/screens/home/home_view_model.dart';

@RoutePage()
class HomeScreenRoot extends StatefulWidget {
  const HomeScreenRoot({
    required this.viewModel,
    required this.adsId,
    super.key,
  });

  final HomeViewModel viewModel;
  final String adsId;

  @override
  State<HomeScreenRoot> createState() => _HomeScreenRootState();
}

class _HomeScreenRootState extends State<HomeScreenRoot> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (BuildContext context, Widget? child) {
        return HomeScreen(
          state: widget.viewModel.state,
          adsId: widget.adsId,
          onAction: (HomeAction action) async {
            switch (action) {
              case OnChangedDuration():
                await widget.viewModel.onAction(action);
              case CheckNotifications():
                await widget.viewModel.onAction(action);
              case CancelNotifications():
                await widget.viewModel.onAction(action);
              case ClearWater():
                await widget.viewModel.onAction(action);
            }
          },
        );
      },
    );
  }
}
