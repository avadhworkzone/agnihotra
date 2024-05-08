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
import 'package:sunrise_app/viewModel/sign_up_controller.dart';

class CreateAccount extends StatelessWidget {
   CreateAccount({super.key});

  final SignUpController signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height/1.45,
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
            height: 12.h,
          ),

          CustomText(
            StringUtils.createAccountTxt,
            color: ColorUtils.orangeE8,
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
          ),

          SizedBox(
            height: 15.h,
          ),

          /// Full Name
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: CustomText(

                StringUtils.nameTxt,
                color: ColorUtils.black13,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          SizedBox(
            height: 5.h,
          ),

          /// Full Name TextField
          SizedBox(
            height: 45.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: CommonTextFormField(
                textEditController: signUpController.fullNameController,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.r),
                  borderSide: BorderSide(color: ColorUtils.grayD1, width: 1.5.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorUtils.orange, width: 1.5.w),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                hintText: StringUtils.fullNameHintTxt,
                hintStyle: TextStyle(fontSize: 14.sp,color: ColorUtils.black1F,fontWeight: FontWeight.w400),
                showLabel: true,
                pIcon: const LocalAssets(
                  imagePath: AssetUtils.nameIcon,
                  scaleSize: 3,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 15.h,
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
                textEditController: signUpController.emailController,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.r),
                  borderSide: BorderSide(color: ColorUtils.grayD1, width: 1.5.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorUtils.orange, width: 1.5.w),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                hintText: StringUtils.emailHintTxt,
                hintStyle: TextStyle(fontSize: 14.sp,color: ColorUtils.black1F,fontWeight: FontWeight.w400),
                showLabel: true,
                pIcon: const LocalAssets(
                  imagePath: AssetUtils.messageIcon,
                  scaleSize: 3,
                ),
              ),
            ),
          ),


          SizedBox(
            height: 15.h,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: CustomText(

                StringUtils.passwordTxt,
                color: ColorUtils.black13,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          SizedBox(
            height: 5.h,
          ),

          /// Password Textfield
          SizedBox(
            height: 45.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: CommonTextFormField(
                textEditController: signUpController.passwordController,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.r),
                  borderSide: BorderSide(color: ColorUtils.grayD1, width: 1.5.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorUtils.orange, width: 1.5.w),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                hintText: StringUtils.passwordHintTxt,
                hintStyle: TextStyle(fontSize: 14.sp,color: ColorUtils.black1F,fontWeight: FontWeight.w400),
                pIcon: const LocalAssets(
                  imagePath: AssetUtils.lockIcon,
                  scaleSize: 3,
                ),
                sIcon: Icon(Icons.remove_red_eye_rounded,
                    color: ColorUtils.gray97.withOpacity(0.6)),
              ),
            ),
          ),



          SizedBox(
            height: 29.h,
          ),

          /// Sign up button
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

            onTap: (){
              // Get.back();


            },
            title: StringUtils.signUpTxt,
            fontSize: 12.sp,

          ),


          SizedBox(
            height: 22.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                height: 1.h,
                width: 93.w,
                color: ColorUtils.grayD1,
              ),

              SizedBox(
                width: 7.w,
              ),

              const CustomText(StringUtils.orSignInWithTxt,color: ColorUtils.black13),
              SizedBox(
                width: 7.w,
              ),
              Container(
                height: 1.h,
                width: 93.w,
                color: ColorUtils.grayD1,
              ),
            ],
          ),

          SizedBox(
            height: 8.h,
          ),

          /// Continue with google
          Container(
            height: 41.h,
            width: 175.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.r),
              color: ColorUtils.grayE4,
            ),
            child: Row(
              children: [

                SizedBox(
                  width: 12.w,
                ),

                const LocalAssets(
                  imagePath: AssetUtils.googleIcon,
                  scaleSize: 3.3,

                ),

                SizedBox(
                  width: 10.w,
                ),

                CustomText(
                  StringUtils.continueGoogleTxt,
                  color: ColorUtils.black1F,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),

              ],
            ),
          ),

         const Spacer(),

          /// You Don’t have any account?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                textAlign: TextAlign.center,
                StringUtils.doNotHaveAccountTxt,
                color: ColorUtils.black13,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                width: 3.w,
              ),
              CustomText(
                textAlign: TextAlign.center,
                StringUtils.loginTxt,
                color: ColorUtils.orangeE8,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              )
            ],
          ),

          SizedBox(
            height: 26.h,
          ),




        ],
      ),
    );
  }
}
