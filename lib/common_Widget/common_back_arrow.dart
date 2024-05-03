import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';

class CommonBackArrow extends StatelessWidget {
  const CommonBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return   CircleAvatar(
      backgroundColor: ColorUtils.white,
      radius: 20.r,
      child: Center(
        child: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(
            size: 22,
            AssetUtils.backArrowIcon,
            color: ColorUtils.orange,
          ),
        ),
      ),
    );
  }
}