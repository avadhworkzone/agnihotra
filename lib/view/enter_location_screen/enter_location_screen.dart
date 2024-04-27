import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/utils/validation_utils.dart';
import 'package:sunrise_app/viewModel/enter_location_controller.dart';
import '../../common_Widget/common_textfield.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  LocationController locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: locationController.validationFormKey,
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
                              color: ColorUtils.black,
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 10.h,),

                            CustomText(
                              StringUtils.notEstSouWesTxt,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorUtils.black,
                              textAlign: TextAlign.center,
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
                                      color: ColorUtils.black,
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
                                        textEditController: locationController.latitudeController,
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
                                      color: ColorUtils.black,
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
                                        textEditController: locationController.longitudeController,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 70.h,),

                            /// Use this Location
                            Obx((){
                              return locationController.isLoad.value
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
                                     locationController.getLatLongLocation();

                                  },
                                  title:StringUtils.locationUseTxt,
                                  fontSize: 15.sp,
                                ),
                              );
                            }),

                            TextButton(
                                onPressed:() {
                                  locationController.getLocationOnMap();

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