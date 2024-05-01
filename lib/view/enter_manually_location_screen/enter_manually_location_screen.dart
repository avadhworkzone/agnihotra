import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/utils/validation_utils.dart';
import 'package:sunrise_app/viewModel/enter_manually_location_controller.dart';
import '../../common_Widget/common_textfield.dart';

class EnterManuallyLocationScreen extends StatefulWidget {
  const EnterManuallyLocationScreen({Key? key}) : super(key: key);

  @override
  State<EnterManuallyLocationScreen> createState() => _EnterManuallyLocationScreenState();
}

class _EnterManuallyLocationScreenState extends State<EnterManuallyLocationScreen> {

  EnterManuallyLocationController enterManuallyLocationController = Get.find<EnterManuallyLocationController>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Form(
        key: enterManuallyLocationController.validationFormKey,
        child: Stack(
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
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding:EdgeInsets.only(left: 12.w),
                    child: CircleAvatar(
                      backgroundColor: ColorUtils.white,
                      radius: 23.r,
                      child: IconButton(
                          onPressed: () {
                            enterManuallyLocationController.latitudeController.clear();
                            enterManuallyLocationController.longitudeController.clear();
                             Get.back();
                          },
                          icon: const Icon(
                            AssetUtils.backArrowIcon,
                            color: ColorUtils.orange,
                          ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80.h,),
                  Padding(
                    padding:EdgeInsets.only(left: 20.w,right: 20.w),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: ColorUtils.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),

                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w,right: 10.w),
                        child: Column(
                          children: [

                            SizedBox(height: 50.h,),

                            CustomText(
                              StringUtils.manuallyEntryTxt,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorUtils.orange,
                            ),

                            SizedBox(height: 10.h,),

                            CustomText(
                              StringUtils.stdConveLocationTxt,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorUtils.black1F,
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 10.h,),

                            CustomText(
                              StringUtils.notEstSouWesTxt,
                              fontSize : 15.sp,
                              fontWeight : FontWeight.w500,
                              color : ColorUtils.black1F,
                              textAlign : TextAlign.center,
                            ),

                            Padding(
                              padding:EdgeInsets.only(left: 8.w),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 35.w,),
                                    child: CustomText(
                                      StringUtils.latiTxt,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                      color: ColorUtils.black1F,
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),

                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: SizedBox(
                                      width: 200.w,
                                      child: CommonTextField(
                                        textAlignVertical: TextAlignVertical.center,
                                        validator: ValidationMethod.latitudeValidation,
                                        textEditController: enterManuallyLocationController.latitudeController,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding:EdgeInsets.only(left: 8.w),
                              child: Row(
                                children: [

                                  Padding(
                                    padding: EdgeInsets.only(top: 35.w),
                                    child: CustomText(
                                      StringUtils.longTxt,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                      color: ColorUtils.black1F,
                                    ),
                                  ),

                                  SizedBox(width: 10.w,),

                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: SizedBox(
                                      width: 200.w,
                                      child: CommonTextField(

                                        textAlignVertical: TextAlignVertical.center,
                                        validator: ValidationMethod.longitudeValidation,
                                        textEditController: enterManuallyLocationController.longitudeController,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 70.h,),

                            /// Use this Location
                            Obx((){
                              return enterManuallyLocationController.isLoad.value
                                  ? const CircularProgressIndicator()
                                  : Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 50.w),
                                child: CustomBtn(
                                  height: 45.h,
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColorUtils.gridentColor1,
                                      ColorUtils.gridentColor2,
                                    ],
                                    begin: AlignmentDirectional.topEnd,
                                    end: AlignmentDirectional.bottomEnd,
                                  ),
                                  onTap: () {
                                     enterManuallyLocationController.getLatLongLocation();

                                  },
                                  title:StringUtils.locationUseTxt,
                                  fontSize: 15.sp,
                                ),
                              );
                            }),

                            TextButton(
                                onPressed :(){

                                  enterManuallyLocationController.getLocationOnMap();

                                },
                              child: CustomText(
                                StringUtils.mapLocationUseTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                color: ColorUtils.orange,
                              ),
                            ),

                            SizedBox(height: 50.h,),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}