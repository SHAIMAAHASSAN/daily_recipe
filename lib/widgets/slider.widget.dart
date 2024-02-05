import 'package:flutter/material.dart';
class SliderWidget extends StatefulWidget {
   SliderWidget({super.key,required this.sliderValue,required this.min,required this.max,required this.division});
 late double sliderValue;
 int division;
 double min;
 double max;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return  Slider(
      value: widget.sliderValue,
      min: 0,
      max: 10,
      divisions: 4,
      activeColor: Colors.deepOrange,
      label: widget.sliderValue.toString(),
      onChanged: (double value) {
        setState(() {
          widget.sliderValue = value;
        });
      },
    );
  }
}
