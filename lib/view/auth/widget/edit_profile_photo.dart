import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';

class EditProfilePhoto extends StatelessWidget {
  const EditProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 85.h,
          width: 85.h,
          decoration: BoxDecoration(
              color: ColorUtils.grayDF,
              borderRadius: BorderRadius.circular(85.r)),
          child: const LocalAssets(
            imagePath: AssetUtils.editProfileIcon,
            scaleSize: 3,
          ),
        ),
        InkWell(
          onTap: () {
            _changeProfilePhoto();
          },
          child: Container(
            height: 22.h,
            width: 22.w,
            decoration: BoxDecoration(
                color: ColorUtils.white,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(width: 0, color: ColorUtils.white),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 4.r,
                      color: ColorUtils.black00.withOpacity(0.25)),
                ]),
            child: const Icon(
              Icons.add,
              size: 20,
              color: ColorUtils.gray55,
            ),
          ),
        ),
      ],
    );
  }

  void _changeProfilePhoto() {
    Get.dialog(
      Padding(
        padding: EdgeInsets.only(left: Get.width/1.8,right:25.w,bottom: Get.height/ 3.3),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.r),
            side: BorderSide.none,
          ),
          backgroundColor: ColorUtils.white,
          shadowColor: ColorUtils.black00.withOpacity(0.18),
          insetPadding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color: ColorUtils.white,
              borderRadius: BorderRadius.circular(9.r),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 15.r,
                    color: ColorUtils.black00.withOpacity(0.18))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  StringUtils.changeProfilePhotoTxt,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: ColorUtils.black1F,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomText(
                  StringUtils.removeProfilePhotoTxt,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: ColorUtils.black1F,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomBtn(
                  height: 25.h,
                  width: 60.w,
                  gradient: const LinearGradient(
                    colors: [
                      ColorUtils.gridentColor1,
                      ColorUtils.gridentColor2,
                    ],
                    begin: AlignmentDirectional.topEnd,
                    end: AlignmentDirectional.bottomEnd,
                  ),
                  onTap: () {
                    Get.back();
                  },
                  title: StringUtils.cancelTxt,
                  fontSize: 12.sp,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
