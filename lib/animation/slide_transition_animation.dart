import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlideTransitionAnimation {

  static void leftToRightAnimation(Widget screen){
    Get.to(screen,transition: Transition.leftToRight,duration: const Duration(milliseconds: 250));
  }

  static void rightToLeftAnimation(Widget screen){
    Get.to(screen,transition: Transition.rightToLeft,duration: const Duration(milliseconds: 250));
  }

  static void rightToLeftAnimationOff(Widget screen){
    Get.off(screen,transition: Transition.rightToLeft,duration: const Duration(milliseconds: 250));
  }

  static void leftToRightAnimationOffAll(Widget screen){
    Get.offAll(screen,transition: Transition.leftToRight,duration: const Duration(milliseconds: 250));
  }


}