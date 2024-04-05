import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';

class MantraScreen extends StatefulWidget {
  const MantraScreen({Key? key}) : super(key: key);

  @override
  State<MantraScreen> createState() => _MantraScreenState();
}

class _MantraScreenState extends State<MantraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                image:AssetImage(
                  AssetUtils.backgroundImages,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(top: 50.h),
            child: Row(
              children: [
                Padding(
                  padding:EdgeInsets.only(left: 12.w),
                  child: CircleAvatar(
                    backgroundColor: ColorUtils.white,
                    radius: 23.r,
                    child: IconButton(
                      onPressed: () {
                        Get.off(SunriseSunetScreen());
                      },
                      icon: const Icon(
                        AssetUtils.backArrowIcon,
                        color: ColorUtils.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:EdgeInsets.only(top: 100.h),
            child: ListView(
              children: [
                SizedBox(height: 40.h,),
                Padding(
                  padding:EdgeInsets.only(left: 20.w,right: 20.w),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h,),
                        Center(
                          child: Container(
                            height: 50.26.h,
                            width: 250.43.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(27.r)),
                              gradient: LinearGradient(
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
                                  padding:EdgeInsets.only(top: 5.h,bottom: 5.h),
                                  child: CircleAvatar(
                                    backgroundColor: ColorUtils.white,
                                    radius: 25.r,
                                    child: LocalAssets(imagePath: AssetUtils.sunriseImages),
                                  ),
                                ),
                                SizedBox(width: 10.w,),
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
                          title:CustomText(
                            'sooryaya swaha',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          subtitle: CustomText(
                            'सूर्याय  स्वाहा',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                        ListTile(
                          title:CustomText(
                            'sooryaya idem na mama',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          subtitle:CustomText(
                            'सूर्याय इदं न मम',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                        ListTile(
                          title:CustomText(
                            'Prajapataye Swaha',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          subtitle:CustomText(
                            'प्रजापतये स्वाहा',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                        ListTile(
                          title:CustomText(
                            'prajapataye idem na mama',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          subtitle:  CustomText(
                            'प्रजापतये इदं न मम',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          trailing: Column(
                            children: [
                              CircleAvatar(
                                radius: 18.r,
                                backgroundColor: ColorUtils.orange,
                                child: Center(
                                  child: Icon(
                                    AssetUtils.playIcon,
                                    color: ColorUtils.white,
                                    size: 35.sp,
                                  )
                                ),
                              ),
                              CustomText(
                                StringUtils.playTxt,
                                color: ColorUtils.orange,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Padding(
                  padding:EdgeInsets.only(left: 20.w,right: 20.w),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h,),
                        Center(
                          child: Container(
                            height: 50.26.h,
                            width: 250.43.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(27.r)),
                              gradient: LinearGradient(
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
                                  padding:EdgeInsets.only(top: 5.h,bottom: 5.h),
                                  child: CircleAvatar(
                                    backgroundColor: ColorUtils.white,
                                    radius: 27.r,
                                    child: LocalAssets(imagePath: AssetUtils.sunsetImages),
                                  ),
                                ),
                                SizedBox(width: 10.w,),
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
                          title:CustomText(
                            'agnaye swaha',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          subtitle: CustomText(
                            'अग्नये स्वाहा',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                        ListTile(
                          title:CustomText(
                            'agnaye idem na mama',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          subtitle:CustomText(
                            'अग्नये इदं न मम',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                        ListTile(
                          title:CustomText(
                            'Prajapataye Swaha',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          subtitle:CustomText(
                            'प्रजापतये स्वाहा',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                        ListTile(
                          title:CustomText(
                            'prajapataye idem na mama',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          subtitle:  CustomText(
                            'प्रजापतये इदं न मम',
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                          trailing: Column(
                            children: [
                              CircleAvatar(
                                radius: 18.r,
                                backgroundColor: ColorUtils.orange,
                                child: Center(
                                    child: Icon(
                                      AssetUtils.playIcon,
                                      color: ColorUtils.white,
                                      size: 35.sp,
                                    )
                                ),
                              ),
                              CustomText(
                                StringUtils.playTxt,
                                color: ColorUtils.orange,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
