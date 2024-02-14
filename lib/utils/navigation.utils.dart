import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_faded_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/animations/rotate_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

abstract class NavigationUtils {
  static push({required BuildContext context, required Widget page}) {
    Navigator.of(context).push(PageAnimationTransition(page: page, pageAnimationType:  LeftToRightFadedTransition()));

   // push(context, MaterialPageRoute(builder: (_) => page));
  }

  static pushReplacement({required BuildContext context, required Widget page}) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page),);
  }
  static pushAndRemoveUntil({required BuildContext context, required Widget page}) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => page), (route) => false);

  }
}