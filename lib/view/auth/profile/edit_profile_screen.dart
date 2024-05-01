import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_back_arrow.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetUtils.backgroundImages,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          /// App bar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  SizedBox(width: 15.w),
                  const CommonBackArrow(),

                  SizedBox(width: 100.w),

                  CustomText(
                    StringUtils.editProfileTxt,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),


                ],
              ),
            ),
          ),

          Container(
            height: Get.height/1.3,
            width: Get.width,
            decoration: BoxDecoration(
                color: ColorUtils.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22.r),
                  topRight: Radius.circular(22.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorUtils.black00.withOpacity(0.21),
                    offset: const Offset(0, -7),
                    blurRadius: 20.r,
                  ),
                ]),
            child: Column(
              children: [
                SizedBox(
                  height: 26.h,
                ),
                CustomText(
                  StringUtils.chooseAccountTxt,
                  color: ColorUtils.orangeE8,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                CustomText(
                  textAlign: TextAlign.center,
                  StringUtils.toContinueTxt,
                  color: ColorUtils.black1F,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 33.h,
                ),
                SizedBox(
                  width: 235.w,
                  height: 45.h,
                  child: CommonTextField(
                    // textEditController: loginController.emailController,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35.r),
                      borderSide: BorderSide(color: ColorUtils.grayE9, width: 1.5.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorUtils.orange, width: 1.5.w),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    hintText: StringUtils.emailHintTxt,
                    pIcon: const LocalAssets(
                      imagePath: AssetUtils.messageIcon,
                      scaleSize: 3,
                    ),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                SizedBox(
                  width: 235.w,
                  height: 45.h,
                  child: CommonTextField(
                    // textEditController: loginController.passwordController,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35.r),
                      borderSide: BorderSide(color: ColorUtils.grayE9, width: 1.5.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorUtils.orange, width: 1.5.w),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    hintText: StringUtils.passwordHintTxt,
                    pIcon: const LocalAssets(
                      imagePath: AssetUtils.lockIcon,
                      scaleSize: 3,
                    ),
                    sIcon: Icon(Icons.remove_red_eye_rounded,
                        color: ColorUtils.gray97.withOpacity(0.6)),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 105.w),
                  child: CustomText(
                    textAlign: TextAlign.center,
                    StringUtils.forgetPwdTxt,
                    color: ColorUtils.orangeE8,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: ColorUtils.orangeE8,
                    ),
                    CustomText(
                      StringUtils.addAnotherAccountTxt,
                      color: ColorUtils.orangeE8,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
                SizedBox(
                  height: 45.h,
                ),
              ],
            ),
          ),
        ],
      ),


    );
  }
}
