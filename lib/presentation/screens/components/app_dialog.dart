import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconBackgroundColor,
    this.showCloseButton = false,
    super.key,
  });

  final Text title;
  final Text message;
  final Color iconBackgroundColor;
  final bool showCloseButton;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: icon,
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [title, message],
            ),
          ],
        ),
      ),
    );
  }
}
