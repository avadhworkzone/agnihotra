import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sunrise_app/animation/slide_transition_animation.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/viewModel/agnihotra_mantra_controller.dart';
import 'agnihotra_patra_screen.dart';

class SunriseSunsetMantraScreen extends StatefulWidget {
  const SunriseSunsetMantraScreen({Key? key}) : super(key: key);

  @override
  State<SunriseSunsetMantraScreen> createState() =>
      _SunriseSunsetMantraScreenState();
}

class _SunriseSunsetMantraScreenState extends State<SunriseSunsetMantraScreen> {
  AgnihotraMantraController agnihotraMantraController =
      Get.find<AgnihotraMantraController>();
  late AudioPlayer meditionBell;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorUtils.white,
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
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 15.w),
                  CircleAvatar(
                    backgroundColor: ColorUtils.white,
                    radius: 20.r,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          size: 22,
                          AssetUtils.backArrowIcon,
                          color: ColorUtils.orange,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 80.w),
                  CustomText(
                    StringUtils.agnihotraMantraTxt,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                  // SizedBox(width: 12.w)
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),

                  /// Agnihotra Patra Size
                  GestureDetector(
                    onTap: () {
                      SlideTransitionAnimation.rightToLeftAnimation(
                          const AgniHotraPatraScreen());
                    },
                    child: Center(
                      child: Container(
                        height: 38.h,
                        width: 240.w,
                        decoration: BoxDecoration(
                            color: ColorUtils.white,
                            borderRadius: BorderRadius.circular(52.r)),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40.w,
                              ),
                              CustomText(
                                StringUtils.agnihotraPatraText,
                                color: ColorUtils.black1F,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                              const Spacer(),
                              Container(
                                height: 25.h,
                                width: 25.h,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColorUtils.orangeCB,
                                      ColorUtils.orangeFD
                                    ],

                                    begin: Alignment.topRight,

                                    end: Alignment
                                        .bottomLeft, // Ending point of the gradient
                                  ),
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: ColorUtils.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: ColorUtils.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),

                          Center(
                            child: Container(
                              height: 50.26.h,
                              width: 250.43.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(27.r)),
                                gradient: const LinearGradient(
                                  colors: [
                                    ColorUtils.gridentColor1,
                                    ColorUtils.gridentColor2,
                                  ],
                                  begin: AlignmentDirectional.topEnd,
                                  end: AlignmentDirectional.bottomEnd,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.h, bottom: 5.h),
                                    child: CircleAvatar(
                                      backgroundColor: ColorUtils.white,
                                      radius: 25.r,
                                      child: LocalAssets(
                                        imagePath: AssetUtils.sunriseImages,
                                        height: 30.63,
                                        width: 30.63,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    StringUtils.sunriseTxt,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          ListTile(
                            title: CustomText(
                              StringUtils.sooryayaSwaha,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                              StringUtils.sooryayaSwahaTxt,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),

                          ListTile(
                            title: CustomText(
                              StringUtils.sooryayaIdem,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                              StringUtils.sooryayaIdemTxt,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),

                          ListTile(
                            title: CustomText(
                              StringUtils.prajapatayeSwaha,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                              StringUtils.prajapatayeSwahaTxt,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),

                          /// Sunrise Manta
                          ListTile(
                            title: CustomText(
                              StringUtils.prajapatayeIdem,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                              StringUtils.prajapatayeIdemTxt,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            trailing: GetBuilder<AgnihotraMantraController>(
                              builder: (controller) {
                                return GestureDetector(
                                  onTap: () {



                                    setState(() {
                                      if (!agnihotraMantraController
                                          .sunsetAudio.playing) {
                                        agnihotraMantraController
                                            .sunriseMantraAudio();
                                      }
                                    });
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 18.r,
                                        backgroundColor: ColorUtils.orange,
                                        child: Center(
                                            child: Icon(
                                          agnihotraMantraController
                                                  .sunriseAudio.playing
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: ColorUtils.white,
                                          size: 28.sp,
                                        )),
                                      ),
                                      CustomText(
                                        agnihotraMantraController
                                                .sunriseAudio.playing
                                            ? StringUtils.pauseTxt
                                            : StringUtils.playTxt,
                                        color: ColorUtils.orange,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: ColorUtils.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),

                          Center(
                            child: Container(
                              height: 50.26.h,
                              width: 250.43.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(27.r)),
                                gradient: const LinearGradient(
                                  colors: [
                                    ColorUtils.gridentColor1,
                                    ColorUtils.gridentColor2,
                                  ],
                                  begin: AlignmentDirectional.topEnd,
                                  end: AlignmentDirectional.bottomEnd,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.h, bottom: 5.h),
                                    child: CircleAvatar(
                                      backgroundColor: ColorUtils.white,
                                      radius: 27.r,
                                      child: LocalAssets(
                                        imagePath: AssetUtils.sunsetImages,
                                        height: 30.63,
                                        width: 30.63,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    StringUtils.sunsetTxt,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          ListTile(
                            title: CustomText(
                              StringUtils.agnayeSwaha,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                              StringUtils.agnayeSwahaTxt,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),

                          ListTile(
                            title: CustomText(
                              StringUtils.agnayeIdem,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                              StringUtils.agnayeIdemTxt,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),

                          ListTile(
                            title: CustomText(
                              StringUtils.prajapatayeSwaha,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                              StringUtils.prajapatayeSwahaTxt,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),

                          /// sunset Mantra
                          ListTile(
                            title: CustomText(
                              StringUtils.prajapatayeIdem,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                              StringUtils.prajapatayeIdemTxt,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            trailing: GetBuilder<AgnihotraMantraController>(
                              builder: (GetxController controller) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (!agnihotraMantraController
                                          .sunriseAudio.playing) {
                                        agnihotraMantraController
                                            .sunsetMantraAudio();
                                      }
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 18.r,
                                        backgroundColor: ColorUtils.orange,
                                        child: Center(
                                            child: Icon(
                                          agnihotraMantraController
                                                  .sunsetAudio.playing
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: ColorUtils.white,
                                          size: 28.sp,
                                        )),
                                      ),
                                      CustomText(
                                        agnihotraMantraController
                                                .sunsetAudio.playing
                                            ? StringUtils.pauseTxt
                                            : StringUtils.playTxt,
                                        color: ColorUtils.orange,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
