import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlideTransitionAnimation{

  static void leftToRightAnimation(Widget screen){
    Get.to(screen,transition: Transition.rightToLeftWithFade,duration: const Duration(milliseconds: 300));
 }



}