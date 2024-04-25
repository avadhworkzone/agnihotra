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
              padding: EdgeInsets.symmetric(horizontal: 14.w),
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
                  Stack(
                      alignment: Alignment.topRight,
                      children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const MantraScreen());

                      },
                      child: SizedBox(
                        height: 180.57.h,
                        child: LocalAssets(
                          imagePath: AssetUtils.agnihotraMantraImages,
                         fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, right: 8.w),
                      child:
                      Column(
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
                      // Container(
                      //   height: 37.h,
                      //   width: 190.w,
                      //   decoration: BoxDecoration(
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: ColorUtils.black00.withOpacity(0.25),
                      //             blurRadius: 4.r,
                      //             offset: const Offset(0, 4)),
                      //       ],
                      //       color: ColorUtils.white,
                      //       borderRadius: BorderRadius.circular(23.r)),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       SizedBox(
                      //         width: 28.w,
                      //       ),
                      //       Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           CustomText(
                      //             StringUtils.agnihotraMantraTxt,
                      //             color: ColorUtils.black,
                      //             fontWeight: FontWeight.w600,
                      //             fontSize: 13.sp,
                      //           ),
                      //           CustomText(
                      //             StringUtils.sunriseSunsetMantraTxt,
                      //             color: ColorUtils.grey73,
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: 10.sp,
                      //           )
                      //         ],
                      //       ),
                      //       const Spacer(),
                      //       Container(
                      //         height: 25.h,
                      //         width: 25.h,
                      //         decoration: BoxDecoration(
                      //           gradient: const LinearGradient(
                      //             colors: [
                      //               ColorUtils.orangeCB,
                      //               ColorUtils.orangeFD
                      //             ],
                      //
                      //             begin: Alignment.topRight,
                      //
                      //             end: Alignment
                      //                 .bottomLeft, // Ending point of the gradient
                      //           ),
                      //           borderRadius: BorderRadius.circular(25.r),
                      //         ),
                      //         child: const Center(
                      //           child: Icon(
                      //             Icons.arrow_forward_ios_outlined,
                      //             color: ColorUtils.white,
                      //             size: 15,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 3.w,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    )
                  ]),
                  SizedBox(
                    height: 16.h,
                  ),
                  Stack(
                      alignment: Alignment.topRight,
                      children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const TrikalSandhyaMantra());

                      },
                      child: SizedBox(
                        height: 180.57.h,
                        child: LocalAssets(
                            imagePath: AssetUtils.trikalSandhyaImages,
                          fit: BoxFit.fill,

                        ),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
