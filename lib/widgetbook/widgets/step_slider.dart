import 'package:flutter/material.dart';
import 'package:mulmuger/presentation/widgets/step_slider.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: StepSlider)
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      StepSlider(
        labelSuffix: context.knobs.string(
          label: '라벨',
          description: '슬라이더 변경 시 라벨 뒤에 붙을 텍스트',
          initialValue: '분',
        ),
        max: context.knobs.double.input(label: '최대 값', initialValue: 60),
        min: context.knobs.double.input(label: '최소 값', initialValue: 5),
        interval: context.knobs.double.input(label: '인터벌', initialValue: 5),
        padding: context.knobs.double.input(label: '패딩', description: '기본 값 0'),
        onChangedEnd: (double value) {},
      ),
    ],
  );
}
