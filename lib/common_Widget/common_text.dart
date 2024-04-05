import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? textAlign;
  final double? height;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final bool? softWrap;

  const CustomText(
      this.title, {
        Key? key,
        this.color,
        this.fontWeight,
        this.fontFamily,
        this.fontSize,
        this.textAlign,
        this.height,
        this.fontStyle,
        this.maxLines,
        this.overflow,
        this.decoration = TextDecoration.none,
        this.letterSpacing,
        this.softWrap,
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      style: TextStyle(
        color: color ?? Get.theme.primaryTextTheme.labelMedium!.color,
        fontFamily: fontFamily ?? 'Poppins-Regular',
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? 14.sp,
        height: height,
        fontStyle: fontStyle,
        overflow: overflow,
        decoration: decoration,
        letterSpacing: letterSpacing,
      ),
    );
  }
}