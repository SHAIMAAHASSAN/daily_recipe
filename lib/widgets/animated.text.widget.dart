import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
class AnimatedTextWidget extends StatefulWidget {
  const AnimatedTextWidget({super.key,required this.text,required this.fontWeight,required this.size});
  final String text;
  final double size;
  final FontWeight fontWeight;

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          widget.text.tr(),

          textStyle:  TextStyle(
            fontSize: widget.size,
            fontWeight: widget.fontWeight,
          ),
          //speed: const Duration(milliseconds: 100),
        ),
      ],

      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 1000),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}
