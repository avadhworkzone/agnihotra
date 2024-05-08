import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_back_arrow.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';

class AgniHotraPatraScreen extends StatefulWidget {
  const AgniHotraPatraScreen({super.key});

  @override
  State<AgniHotraPatraScreen> createState() => _AgniHotraPatraScreenState();
}

class _AgniHotraPatraScreenState extends State<AgniHotraPatraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 15.w),
                  const CommonBackArrow(),
                  SizedBox(width: 65.w),
                  CustomText(
                    StringUtils.agnihotraPatraText,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),

                ],
              ),
            ),
          ),

          Padding(
              padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 130.h),
              child: LocalAssets(imagePath: AssetUtils.agniHotraPatra))
        ],
      ),
    );
  }
}
