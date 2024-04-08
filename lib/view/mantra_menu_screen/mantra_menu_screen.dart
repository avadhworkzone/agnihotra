import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/mantra_screen/mantra_screen.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';

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
              image:DecorationImage(
                image:AssetImage(
                  AssetUtils.backgroundImages,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 90.h,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 12.w),
                child:  CircleAvatar(
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
              SizedBox(height: 40.h,),
              Padding(
                padding: EdgeInsets.only(left: 10.w,right: 10.w),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: ColorUtils.white,
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 80.h,
                      width: 65.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        image: DecorationImage(image: AssetImage(AssetUtils.agniKundImages),fit: BoxFit.cover)
                      ),
                    ),
                    title: CustomText(
                      StringUtils.agnihotraMantraTxt,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: ColorUtils.black,
                    ),
                    subtitle: CustomText(
                        StringUtils.sunriseSunsetMantraTxt,
                        color: ColorUtils.greyColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                   trailing: Container(
                     height: 40.h,
                     width: 40.w,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       gradient: LinearGradient(
                         colors: [
                           ColorUtils.gridentColor1,
                           ColorUtils.gridentColor2,
                         ],
                         begin: AlignmentDirectional.topEnd,
                         end: AlignmentDirectional.bottomEnd,
                       ),
                     ),
                     child: IconButton(
                         onPressed: () {
                           Get.off(MantraScreen());
                         },
                         icon:Icon(
                           AssetUtils.forwardArrowIcon,
                           color: ColorUtils.white,
                         )
                     ),
                   ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding: EdgeInsets.only(left: 10.w,right: 10.w),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: ColorUtils.white,
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  ),
                  child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 5.w,bottom: 5.w),
                      child: Container(
                        height: 85.h,
                        width: 65.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.r)),
                            image: DecorationImage(image: AssetImage(AssetUtils.tilakSndhyaImages),fit: BoxFit.cover)
                        ),
                      ),
                    ),
                    title: CustomText(
                      StringUtils.tilakSandhyaMantraTxt,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: ColorUtils.black,
                    ),
                    trailing: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            ColorUtils.gridentColor1,
                            ColorUtils.gridentColor2,
                          ],
                          begin: AlignmentDirectional.topEnd,
                          end: AlignmentDirectional.bottomEnd,
                        ),
                      ),
                      child: IconButton(
                          onPressed: () {
                          //  Get.off(MantraScreen());
                          },
                          icon:Icon(
                            AssetUtils.forwardArrowIcon,
                            color: ColorUtils.white,
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
