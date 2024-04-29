import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                image:AssetImage(
                  AssetUtils.loginBackgroundImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 80.w,
            top: 80.h,
            child: LocalAssets(
                imagePath: AssetUtils.agnihotraHvanKund,
              height: 109.2.h,
              width: 199.89.w,
            ),
          ),
          Positioned(
            left: 90.w,
            top: 160.h,
            child: LocalAssets(
              imagePath: AssetUtils.agnihotrTxtImage,
              height: 109.2.h,
              width: 199.89.w,
            ),
          ),
          Positioned(
            left: 65.w,
            top: 250.h,
            child: CustomText(
              StringUtils.rogmuktaabiyanTxt,
              fontSize: 23.sp,
              fontWeight: FontWeight.w700,
              color: ColorUtils.sunriseSunsetMantraColor,
            ),
          )
        ],
      ),
      bottomSheet: Container(
        height: 400.26.h,
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorUtils.white,
          borderRadius: BorderRadius.all(Radius.circular(30.r),),
        ),
        child:Column(
          children: [

          ],
        ),
      ),
    );
  }
}
