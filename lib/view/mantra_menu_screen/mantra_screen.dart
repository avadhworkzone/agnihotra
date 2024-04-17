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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:EdgeInsets.only(left: 12.w),
                  child: CircleAvatar(
                    backgroundColor: ColorUtils.white,
                    radius: 18.r,
                    child: IconButton(
                      onPressed: () {
                        Get.off(SunriseSunetScreen());
                      },
                      icon:  Icon(
                        size: 20.w,
                        AssetUtils.backArrowIcon,
                        color: ColorUtils.orange,
                      ),
                    ),
                  ),
                ),
                CustomText(
                  StringUtils.agnihotraMantraTxt,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
                SizedBox(width: 12.w)
              ],
            ),
          ),
          Padding(
            padding:EdgeInsets.only(top: 100.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
               //   SizedBox(height: 20.h,),
                  Container(
                    height: 65.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(image:AssetImage(AssetUtils.agniKundImages),fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10.w,
                          color: ColorUtils.greyColor,
                        ),
                      ]
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
                              width: 230.43.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(27.r)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:EdgeInsets.only(top: 5.h,bottom: 5.h),
                                    child: CircleAvatar(
                                      backgroundColor: ColorUtils.white,
                                      radius: 25.r,
                                      child: LocalAssets(imagePath: AssetUtils.sunriseImages),
                                    ),
                                  ),
                                  CustomText(
                                    StringUtils.sunriseTxt,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.sp,
                                  ),
                                SizedBox(width: 10.w,),

                        ],
                              ),
                            ),
                          ),
                          ListTile(
                            title:CustomText(
                              StringUtils.sooryayaSwaha,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                             StringUtils.sooryayaSwahaTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),
                          ListTile(
                            title:CustomText(
                              StringUtils.sooryayaIdem,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle:CustomText(
                              StringUtils.sooryayaIdemTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),
                          ListTile(
                            title:CustomText(
                              StringUtils.prajapatayeSwaha,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle:CustomText(
                              StringUtils.prajapatayeSwahaTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),
                          ListTile(
                            title:CustomText(
                              StringUtils.prajapatayeIdem,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle:  CustomText(
                              StringUtils.prajapatayeIdemTxt,
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
                              width: 230.43.w,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:EdgeInsets.only(top: 5.h,bottom: 5.h),
                                    child: CircleAvatar(
                                      backgroundColor: ColorUtils.white,
                                      radius: 27.r,
                                      child: LocalAssets(imagePath: AssetUtils.sunsetImages),
                                    ),
                                  ),
                                  CustomText(
                                    StringUtils.sunsetTxt,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.sp,
                                  ),
                                  SizedBox(width: 10.w,),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title:CustomText(
                              StringUtils.agnayeSwaha,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle: CustomText(
                              StringUtils.agnayeSwahaTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),
                          ListTile(
                            title:CustomText(
                              StringUtils.agnayeIdem,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle:CustomText(
                              StringUtils.agnayeIdemTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),
                          ListTile(
                            title:CustomText(
                              StringUtils.prajapatayeSwaha,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle:CustomText(
                              StringUtils.prajapatayeSwahaTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ),
                          ListTile(
                            title:CustomText(
                              StringUtils.prajapatayeIdem,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            subtitle:  CustomText(
                              StringUtils.prajapatayeIdemTxt,
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
                                const CustomText(
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
          ),
        ],
      ),
    );
  }
}
