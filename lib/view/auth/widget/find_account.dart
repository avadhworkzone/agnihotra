import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/viewModel/forgot_password_controller.dart';


class FindAccount extends StatelessWidget {
   FindAccount({super.key});

 final ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 1.45,
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
            height: 47.h,
          ),

          CustomText(
            StringUtils.forgetPwdScrrenTxt,
            color: ColorUtils.orangeE8,
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
          ),

          SizedBox(
            height: 15.h,
          ),

          CustomText(
            textAlign: TextAlign.center,
            StringUtils.enterYourEmailAddressTxt,
            color: ColorUtils.black1F,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),

          SizedBox(
            height: 30.h,
          ),


          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: CustomText(
                StringUtils.emailAddressTxt,
                color: ColorUtils.black13,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          SizedBox(
            height: 5.h,
          ),



          /// Email TextField
          SizedBox(
            height: 45.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: CommonTextFormField(
                textEditController: forgotPasswordController.emailController,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.r),
                  borderSide: BorderSide(color: ColorUtils.grayD1, width: 1.5.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorUtils.orange, width: 1.5.w),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                hintText: StringUtils.emailHintTxt,
                hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: ColorUtils.black1F,
                    fontWeight: FontWeight.w400),
                showLabel: true,
                pIcon: const LocalAssets(
                  imagePath: AssetUtils.messageIcon,
                  scaleSize: 3,
                ),
              ),
            ),
          ),





          SizedBox(
            height: 96.h,
          ),


          /// Password Reset
          CustomBtn(
            height: 33.h,
            width: 146.w,
            gradient: const LinearGradient(
              colors: [
                ColorUtils.gridentColor1,
                ColorUtils.gridentColor2,
              ],
              begin: AlignmentDirectional.topEnd,
              end: AlignmentDirectional.bottomEnd,
            ),
            onTap: () {
              // Get.back();
            },
            title: StringUtils.resetPasswordBtnTxt,
            fontSize: 12.sp,
          ),





        ],
      ),
    );
  }
}