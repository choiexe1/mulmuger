import 'package:flutter/material.dart';

class StepSlider extends StatefulWidget {
  const StepSlider({
    required this.labelSuffix,
    required this.max,
    required this.interval,
    required this.onChangedEnd,
    super.key,
    this.min = 0,
    this.value = 0,
    this.padding = 0,
  });

  final String labelSuffix;
  final double value;
  final double max;
  final double min;
  final double interval;
  final double padding;
  final ValueChanged<double> onChangedEnd;

  @override
  State<StatefulWidget> createState() => _StepSliderState();
}

class _StepSliderState extends State<StepSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = _roundToInterval(widget.value);
  }

  @override
  void didUpdateWidget(covariant StepSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = _roundToInterval(widget.value);
    }
  }

  double _roundToInterval(double val) {
    final roundedValue = (val / widget.interval).round() * widget.interval;
    if (roundedValue < widget.min) return widget.min;
    if (roundedValue > widget.max) return widget.max;
    return roundedValue;
  }

  void _setValue(double newValue) {
    setState(() {
      _value = _roundToInterval(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final divisions = ((widget.max - widget.min) / widget.interval).round();

    return Slider(
      padding: widget.padding != 0
          ? EdgeInsets.all(widget.padding)
          : EdgeInsets.zero,
      activeColor: Colors.blue,
      value: _value,
      min: widget.min,
      max: widget.max,
      divisions: divisions,
      label: '${_value.round()}${widget.labelSuffix}',
      onChanged: _setValue,
      onChangeEnd: (value) {
        widget.onChangedEnd(value);
      },
    );
  }
}
