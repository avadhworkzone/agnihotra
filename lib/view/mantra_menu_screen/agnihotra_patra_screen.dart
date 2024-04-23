import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';

class AgniHotraPatraScreen extends StatefulWidget {
  const AgniHotraPatraScreen({super.key});

  @override
  State<AgniHotraPatraScreen> createState() => _AgniHotraPatraScreenState();
}

class _AgniHotraPatraScreenState extends State<AgniHotraPatraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
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

          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: CircleAvatar(
              backgroundColor: ColorUtils.white,
              radius: 20.r,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  AssetUtils.backArrowIcon,
                  color: ColorUtils.orange,
                ),
              ),
            ),
          ),


          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 70.h),
              child: LocalAssets(imagePath: AssetUtils.agniHotraPatra))

        ],
      )),
    );
  }
}
