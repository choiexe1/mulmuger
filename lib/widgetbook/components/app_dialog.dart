import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mulmuger/presentation/screens/components/animated_button.dart';
import 'package:mulmuger/presentation/screens/components/app_dialog.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppDialog)
Widget build(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: '알림 확인');

  final message = context.knobs.string(
    label: 'message',
    initialValue: '예약된 알림이 없어요!',
  );

  final showCloseButton = context.knobs.boolean(
    label: 'showCloseButton',
    initialValue: true,
  );

  final duration = context.knobs.duration(
    label: 'autoCloseSeconds',
    initialValue: const Duration(milliseconds: 2500),
  );

  return AnimatedButton(
    text: const Text('Tap to Open Dialog'),
    onTap: () {
      showGeneralDialog(
        barrierLabel: 'Label',
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.5),
        transitionDuration: const Duration(milliseconds: 300),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          Timer(duration, () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });

          return AppDialog(
            title: Text(title, style: const TextStyle(color: Colors.black)),
            onTapClose: () => Navigator.pop(context),
            showCloseButton: showCloseButton,
            message: Text(
              message,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.6),
                fontSize: 12,
              ),
            ),
            icon: const Icon(Icons.info_outline, color: Colors.white),
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
  );
}
