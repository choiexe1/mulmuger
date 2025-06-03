import 'package:flutter/material.dart';
import 'package:mulmuger/presentation/screens/components/animated_button.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AnimatedButton)
Widget build(BuildContext context) {
  return AnimatedButton(
    text: Text(
      style: const TextStyle(color: Colors.white),
      context.knobs.string(label: 'text', initialValue: 'AnimatedButton'),
    ),
    onTap: () {},
  );
}
