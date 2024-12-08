import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

class SliderWidget extends StatelessWidget {
  final String label;
  final double value;
  final double max;
  final double min;
  final double division;
  final Function(double) onChanged;

  SliderWidget(
      {required this.label,
      required this.value,
      required this.max,
      required this.min,
      required this.division,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(label,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
          flex: 4,
          child: Slider(
            activeColor: Colors.green,
            value: value,
            max: max,
            min: min,
            divisions: division.toInt(),
            label: value.round().toString(),
            onChanged: onChanged,
          ),
        ),
        Expanded(
            flex: 1,
            child: value == 0
                ? Text("")
                : Text(
                    "${value.toInt()} ${label.contains('Power') ? 'CC' : label.contains('Kms') ? 'kms' : 'years'}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: label.contains("Kms") ? 10 : 11,
                        fontWeight: FontWeight.bold),
                  )),
      ],
    );
  }
}
