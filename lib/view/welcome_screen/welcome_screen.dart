import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/viewModel/enter_location_controller.dart';
import 'package:sunrise_app/viewModel/settings_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedValue = '';

  LocationController locationController = Get.find<LocationController>();
  SettingScreenController settingScreenController =   Get.find<SettingScreenController>();


  @override
  void initState() {
    locationController.getCurrentLocation();
    settingScreenController.isScreenOn.value = PrefServices.getBool('keepScreenOn');
    print("settingScreenController.isScreenOn.value :- ${settingScreenController.isScreenOn.value}");
    if (settingScreenController.isScreenOn.value){
      KeepScreenOn.turnOn();
    }
    super.initState();
  }

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

        ],
      ),
      bottomSheet: Container(
          height: 400.26.h,
          width: Get.width,
          decoration: BoxDecoration(
            color: ColorUtils.white,
            borderRadius: BorderRadius.all(Radius.circular(30.r),),
          ),
          child: Column(
            children: [
              SizedBox(height: 30.h,),
              // LANGUAGE CHOOSE
              CustomText(
                StringUtils.languageChooseTxt,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: ColorUtils.black,
              ),
              SizedBox(height: 5.h,),
              // SELECT LANGUAGE TO USE
              CustomText(
                StringUtils.languageUseTxt,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: ColorUtils.orange,
              ),
              SizedBox(height: 30.h,),
              /// HINDI
              Padding(
                padding:EdgeInsets.only(left: 45.w,right: 45.w),
                child: Container(
                  height: 45.88.h,
                  width: Get.width,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(27.r)),
                   border: Border.all(
                     width: 1.5.w,
                     color: ColorUtils.borderColor,
                   ),
                 ),
                  child:  Padding(
                    padding:EdgeInsets.only(left: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          StringUtils.hinTxt,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorUtils.black,
                        ),
                        Radio(
                            value: 'Hindi',
                            groupValue: selectedValue,
                            onChanged:(value) {
                             setState(() {
                               selectedValue = value.toString();
                             });
                            },
                          fillColor: MaterialStateColor.resolveWith((states) => ColorUtils.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              /// ENGLISH
              Padding(
                padding:EdgeInsets.only(left: 45.w,right: 45.w),
                child: Container(
                  height: 45.88.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(27.r),),
                    border: Border.all(
                      width: 1.5.w,
                      color: ColorUtils.borderColor,
                    ),
                  ),
                  child:  Padding(
                    padding:EdgeInsets.only(left: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          StringUtils.engTxt,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorUtils.black,
                        ),
                        Radio(
                          value: 'English',
                          groupValue: selectedValue,
                          onChanged:(value) {
                            setState(() {
                              selectedValue = value.toString();

                            });
                          },
                          fillColor: MaterialStateColor.resolveWith((states) => ColorUtils.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              /// GUJARATI
              Padding(
                padding:EdgeInsets.only(left: 45.w,right: 45.w),
                child: Container(
                  height: 45.88.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(27.r)),
                    border: Border.all(
                      width: 1.5.w,
                      color: ColorUtils.borderColor,
                    ),
                  ),
                  child:  Padding(
                    padding:EdgeInsets.only(left: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          StringUtils.gujTxt,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorUtils.black,
                        ),
                        Radio(
                          value: 'Gujarati',
                          groupValue: selectedValue,
                          onChanged:(value) {
                            setState(() {
                              selectedValue = value.toString();

                            });
                          },
                          fillColor: MaterialStateColor.resolveWith((states) => ColorUtils.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h,),

              /// SUBMIT BUTTON
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 80.w),
                child: CustomBtn(
                  height: 50.h,
                    gradient: const LinearGradient(
                        colors: [
                           ColorUtils.gridentColor1,
                           ColorUtils.gridentColor2,
                        ],
                      begin: AlignmentDirectional.topEnd,
                      end: AlignmentDirectional.bottomEnd,
                    ),
                    onTap: () async {
                     if(selectedValue.isNotEmpty){
                       switch(selectedValue){
                         case 'Hindi':
                           Get.updateLocale(const Locale('hi'));
                           await PrefServices.setValue('language', 'hi');
                           break;
                         case 'English':
                           Get.updateLocale(const Locale('en_US'));
                           await PrefServices.setValue('language', 'en_US');
                           break;
                         case 'Gujarati':
                           Get.updateLocale(const Locale('gu'));
                           await PrefServices.setValue('language', 'gu');
                           break;
                         default :
                           break;
                       }
                       Get.off(SunriseSunetScreen());
                     }else{
                       Fluttertoast.showToast(
                           msg: "Please Selected Language",
                           toastLength: Toast.LENGTH_SHORT,
                           timeInSecForIosWeb: 1,
                           textColor: Colors.white,
                           fontSize: 16.0
                       );
                     }
                    },
                    title: StringUtils.submitBtnTxt,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
