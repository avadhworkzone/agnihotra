import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';

class CustomBtn extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final double? radius;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;
  final bool? isDownloadFile;
  final IconData? leading;
  final bool? withIcon;
  final String? iconPath;
  final bool? transparent;
  final Gradient? gradient;

  const CustomBtn(
      {required this.onTap,
        required this.title,
        this.radius,
        this.borderColor,
        this.height,
        this.width,
        this.fontSize,
        this.bgColor,
        this.textColor,
        this.leading,
        this.withIcon = false,
        this.iconPath,
        this.isDownloadFile = false,
        this.transparent = false, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 61.02.h,
      width: width ?? Get.width,
      decoration: BoxDecoration(
        color: bgColor ?? ColorUtils.white,
        borderRadius: BorderRadius.circular(radius ?? 6.r),
        gradient: gradient,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius ?? 30.r),
          onTap: onTap,
          child: Center(
            child: CustomText(
              title!,
              fontWeight: FontWeight.w600,
              color: textColor ?? ColorUtils.white,
              fontSize: fontSize ?? 17.sp,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
