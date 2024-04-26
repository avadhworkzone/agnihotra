import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/mantra_menu_screen/mantra_screen.dart';
import 'package:sunrise_app/view/mantra_menu_screen/trikal_sandhya_mantra_screen.dart';

class MantraMenuScreen extends StatefulWidget {
  const MantraMenuScreen({Key? key}) : super(key: key);

  @override
  State<MantraMenuScreen> createState() => _MantraMenuScreenState();
}

class _MantraMenuScreenState extends State<MantraMenuScreen> {
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
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CircleAvatar(
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

                  SizedBox(
                    height: 30.h,
                  ),

                  /// Agnihotra Mantra
                  GestureDetector(
                    onTap: () {
                      Get.to(const MantraScreen());
                    },
                    child: Stack(
                        alignment: Alignment.topRight, children: [

                      SizedBox(
                        height: 183.57.h,
                        width: Get.width,
                        child: LocalAssets(
                          imagePath: AssetUtils.agnihotraMantraImages,
                          fit: BoxFit.fill,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 10.h, right: 8.w),
                        child: Column(
                          children: [
                            CustomText(
                              StringUtils.agnihotraMantraTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                            CustomText(
                              StringUtils.sunriseSunsetMantraTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            )
                          ],
                        ),

                      )

                    ]),
                  ),

                  SizedBox(
                    height: 16.h,
                  ),

                  /// Trikal Sandhya
                  GestureDetector(
                    onTap: () {
                      Get.to(const TrikalSandhyaMantra());
                    },
                    child: Stack(alignment: Alignment.topRight, children: [
                      SizedBox(
                        height: 187.57.h,
                        child: LocalAssets(
                          imagePath: AssetUtils.trikalSandhyaImages,
                          fit: BoxFit.fill,
                          width: Get.width,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, right: 50.w),
                        child: Column(
                          children: [
                            CustomText(
                              StringUtils.trikalMantraTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}