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
import 'package:sunrise_app/view/auth/widget/edit_profile_field.dart';
import 'package:sunrise_app/view/auth/widget/edit_profile_photo.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.gray55,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          /// bg Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetUtils.authScreenBg,
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

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height/1.2,
              width: Get.width,
              decoration: BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.r),
                    topRight: Radius.circular(22.r),
                  ),

              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 34.h,
                    ),
                    const EditProfilePhoto(),
                     EditProfileField(),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
