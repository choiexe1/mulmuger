import 'package:flutter/material.dart';
import 'package:mulmuger/presentation/widgets/water_bottle.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: WaterBottle)
Widget build(BuildContext context) {
  return WaterBottle(
    percentage: context.knobs.double.input(
      label: 'percentage',
      description:
          '물병에 채울 물의 양을 0 ~ 1.0로 조절 합니다. percentage는 위젯 내부 변수 limit을 넘지 못합니다.',
    ),
  );
}
