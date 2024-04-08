import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/enter_location_screen/enter_location_screen.dart';
import 'package:sunrise_app/view/google_map_screen/google_map.dart';
import 'package:sunrise_app/view/mantra_menu_screen/mantra_menu_screen.dart';
import 'package:sunrise_app/view/mantra_screen/mantra_screen.dart';
import 'package:sunrise_app/view/setting_screen/setting_screen.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';

class SunriseSunetScreen extends StatefulWidget {
//  SunriseSunetScreen({Key? key, this.latitude, this.longitude, this.address, this.value}) : super(key: key);

  double? latitude;
  double? longitude;
  String? address;
  bool? value;

  SunriseSunetScreen({Key? key, this.latitude, this.longitude, this.address, this.value}) : super(key: key) {
    // if (address != null && latitude != null && longitude != null) {
    //   PrefServices.setValue('address', address!);
    //   PrefServices.setValue('latitude', latitude!);
    //   PrefServices.setValue('longitude', longitude!);
    // }
  }

  @override
  State<SunriseSunetScreen> createState() => _SunriseSunetScreenState();
}

class _SunriseSunetScreenState extends State<SunriseSunetScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SunriseSunsetController sunriseSunsetController =
      Get.find<SunriseSunsetController>();
  GoogleController googleController = Get.find<GoogleController>();

  String formatAddress() {
    // if (widget.address == null || (widget.latitude == 0 && widget.longitude == 0)) {
    //   return 'Location not set, click on icon!';
    //  }
    //
    // List<String> addressParts = widget.address!.split(',').map((part) => part.trim()).toList();
    // addressParts.removeWhere((part) => part.isEmpty);
    //
    // return addressParts.join(', ');
    if (address == null || (latitude == 0 && longitude == 0)) {
      return StringUtils.locationSetTxt;
    }

    List<String> addressParts = address!.split(',').map((part) => part.trim()).toList();
    addressParts.removeWhere((part) => part.isEmpty);

    return addressParts.join(', ');
  }

  String formateLatitudeLongitude(double value){
    String formattedValue = value.toStringAsFixed(4);
    return formattedValue;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAddress();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.value == true){
        Get.dialog(
          AlertDialog(
            title: CustomText(
              'Please confirm timesone for this location',
              color: ColorUtils.black,
            ),
            content: CustomText(
              'India Standard Time(Asia/Kolkata)',
              color: ColorUtils.black,
            ),
            actions: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: CustomText(
                      'Change Timezone',
                      color: ColorUtils.black,
                    ),
                  ),
                  CustomBtn(
                    width: 80.w,
                    height: 40.h,
                    onTap: () {
                      setState(() {
                        latitude = widget.latitude!;
                        longitude = widget.longitude!;
                        address = widget.address!;
                      });
                      if (address != null && latitude != null && longitude != null) {
                        PrefServices.setValue('address', address!);
                        PrefServices.setValue('latitude', latitude!);
                        PrefServices.setValue('longitude', longitude!);
                      }
                    //   googleController.onLocationData(
                    //     widget.address ?? googleController.address.value,
                    //     widget.latitude ?? googleController.lastMapPosition.value!.latitude,
                    //     widget.longitude ?? googleController.lastMapPosition.value!.longitude,
                    //   );
                    // Get.back(result:googleController.result.value = false);
                      Get.back();
                    },
                    title: 'Confirm',
                    bgColor: ColorUtils.orange,
                  ),
                ],
              ),
            ],
          ),
        );
      }
    });

  }
  Future<void> _loadAddress() async {
    String? storedAddress = await PrefServices.getString('address');
    List<String> storedLocationList = PrefServices.getStringList('locationList');
    double? storedLatitude = await PrefServices.getDouble('latitude');
    double? storedLongitude = await PrefServices.getDouble('longitude');

    if (storedAddress != null) {
      setState(() {
        if (address == null) {
         address = storedAddress;
        }
      });
    } else {
      setState(() {
        address = null;
      });
    }
    if (storedLatitude != null) {
      setState(() {
        if (latitude == null) {
          latitude = storedLatitude;
        }
      });
    } else {
      setState(() {
      latitude = null;
      });
    }

    if (storedLongitude != null) {
      setState(() {
        if (longitude == null) {
          longitude = storedLongitude;
        }
      });
    } else {
      setState(() {
        longitude = null;
      });
    }
    if(storedLocationList !=null){
      setState(() {
        googleController.locationList.value = RxList<String>(storedLocationList);
      });
    }
  }
  Future<void> _clearData() async {
    await PrefServices.removeValue('address');
    await PrefServices.removeValue('latitude');
    await PrefServices.removeValue('longitude');
    await PrefServices.removeValue('locationList');
  }
 double? latitude;
 double? longitude;
 String? address;

  @override
  Widget build(BuildContext context) {
    // if (widget.latitude != null && widget.longitude != null && (widget.latitude != 0 || widget.longitude != 0)) {
    //   sunriseSunsetController.fetchWeather(widget.latitude!, widget.longitude!);
    // }
    if (latitude != null && longitude != null && (latitude != 0 || longitude != 0)) {
      sunriseSunsetController.fetchWeather(latitude!, longitude!);
    }
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
       width: 250.w,
       shape: OutlineInputBorder(
         borderRadius: BorderRadius.all(Radius.circular(28.r)),
       ),
       child: Padding(
         padding:EdgeInsets.only(left: 20.w,right: 20.w),
         child: Column(
           children: [
             SizedBox(height: 100.h,),
             InkWell(
               onTap: () {
                 Get.to(const SettingsScreen());
               },
               child: Row(
                 children: [
                   const Icon(
                     AssetUtils.seetingIcon,
                     color: ColorUtils.orange,
                   ),
                   SizedBox(width: 10.w,),
                   CustomText(
                     StringUtils.SettingsScreenTxt,
                     fontWeight: FontWeight.w500,
                     fontSize: 15.sp,
                     color: ColorUtils.black,
                   ),
                 ],
               ),
             ),
             Divider(),
             SizedBox(height: 10.h,),
             Row(
               children: [
                LocalAssets(
                    imagePath: AssetUtils.contactsImages,
                  height: 20.h,
                  fit: BoxFit.fitHeight,
                ),
                 SizedBox(width: 10.w,),
                 CustomText(
                   StringUtils.contactsTxt,
                   fontWeight: FontWeight.w500,
                   fontSize: 15.sp,
                   color: ColorUtils.black,
                 ),
               ],
             ),
             Divider(),
             SizedBox(height: 10.h,),
             Row(
               children: [
                 LocalAssets(
                     imagePath: AssetUtils.languageImages,
                   height: 25.h,
                   fit: BoxFit.fitHeight,
                 ),
                 SizedBox(width: 10.w,),
                 CustomText(
                   StringUtils.languageTxt,
                   fontWeight: FontWeight.w500,
                   fontSize: 15.sp,
                   color: ColorUtils.black,
                 ),
               ],
             ),
             Divider(),
             SizedBox(height: 10.h,),
             Row(
               children: [
                Icon(
                  AssetUtils.aboutIcon,
                  color: ColorUtils.orange,
                ),
                 SizedBox(width: 10.w,),
                 CustomText(
                   StringUtils.aboutTxt,
                   fontWeight: FontWeight.w500,
                   fontSize: 15.sp,
                   color: ColorUtils.black,
                 ),
               ],
             ),
             Divider(),
             SizedBox(height: 10.h,),
             Row(
               children: [
                 LocalAssets(
                     imagePath: AssetUtils.privacyPolicyImages,
                   height: 25.h,
                   fit: BoxFit.fitHeight,
                 ),
                 SizedBox(width: 10.w,),
                 CustomText(
                   StringUtils.privacyPolicyTxt,
                   fontWeight: FontWeight.w500,
                   fontSize: 15.sp,
                   color: ColorUtils.black,
                 ),
               ],
             ),
             Divider(),
             SizedBox(height: 10.h,),
             Row(
               children: [
                Icon(
                  AssetUtils.shareIcon,
                  color: ColorUtils.orange,
                ),
                 SizedBox(width: 10.w,),
                 CustomText(
                   StringUtils.shareTxt,
                   fontWeight: FontWeight.w500,
                   fontSize: 15.sp,
                   color: ColorUtils.black,
                 ),
               ],
             ),
             Divider(),
             SizedBox(height: 10.h,),
             Row(
               children: [
                Icon(
                  AssetUtils.helpIcon,
                  color: ColorUtils.orange,
                ),
                 SizedBox(width: 10.w,),
                 CustomText(
                   StringUtils.helpTxt,
                   fontWeight: FontWeight.w500,
                   fontSize: 15.sp,
                   color: ColorUtils.black,
                 ),
               ],
             ),
           ],
         ),
       ),
     ),
      body: Obx(() {
        String sunrise = sunriseSunsetController.sunrise.value;
        String sunset = sunriseSunsetController.sunset.value;
       return Stack(
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
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //  MANTRA TXT
                        InkWell(
                          onTap: () {
                            Get.to(const MantraMenuScreen());
                          },
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.all(Radius.circular(24.r)),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  AssetUtils.mantraImages,
                                ),
                                // LocalAssets(
                                //     imagePath: AssetUtils.mantraImages,
                                // ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                CustomText(
                                  StringUtils.mantraTxt,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorUtils.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // MENU ICON
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: CircleAvatar(
                            radius: 17.r,
                            backgroundColor: ColorUtils.white,
                            child: Icon(
                              AssetUtils.menuIcon,
                              color: ColorUtils.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  // CALENDAR ICON
                  const CircleAvatar(
                    backgroundColor: ColorUtils.white,
                    child: Icon(
                      AssetUtils.calendarIcon,
                      color: ColorUtils.orange,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // DATE
                  CustomText(
                    sunriseSunsetController.formattedDate,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // TIME
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                      border: Border.all(color: ColorUtils.borderColor),
                     boxShadow: [
                        BoxShadow(
                          color: ColorUtils.white,
                          blurRadius: 200.w,
                        )
                     ],
                    ),
                    child: CustomText(
                      sunriseSunsetController.formattedTime,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 90.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SUNRISE
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 23.h),
                            child: Container(
                              height: 79.13.h,
                              width: 137.53.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6.r)),
                                  border: Border.all(
                                    color: ColorUtils.borderColor,
                                  ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorUtils.white,
                                    blurRadius: 300.w,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 25.h),
                                child:sunriseSunsetController.isLoad.value?CircularProgressIndicator(color: ColorUtils.white,)
                                    :CustomText(
                                  sunrise,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 40.w,
                            child: CircleAvatar(
                              backgroundColor: ColorUtils.white,
                              radius: 27.r,
                              child: LocalAssets(imagePath: AssetUtils.sunriseImages),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      // SUNSET
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 23.h),
                            child: Container(
                              height: 79.13.h,
                              width: 137.53.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                  border: Border.all(
                                    color: ColorUtils.borderColor,
                                  ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorUtils.white,
                                    blurRadius: 200.w,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 25.h),
                                child:sunriseSunsetController.isLoad.value?CircularProgressIndicator(color: ColorUtils.white,)
                                    :CustomText(
                                  sunset,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 40.w,
                            child: CircleAvatar(
                              backgroundColor: ColorUtils.white,
                              radius: 27.r,
                              child: LocalAssets(
                                imagePath: AssetUtils.sunsetImages,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 130.h,
                  ),
                  // ADD LOCATION
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 23.h),
                        child: Container(
                          // height: 63.93.h,
                          width: 287.83.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.all(Radius.circular(52.r)),
                              border: Border.all(
                                color: ColorUtils.borderColor,
                              )),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20.w, right: 20.w,top: 30.h),
                                      child: CustomText(
                                        formatAddress(),
                                        textAlign: TextAlign.center,
                                        color: ColorUtils.black,
                                      ),
                                    ),
                              if (latitude != null && longitude != null && (latitude != 0 || longitude != 0))
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                  child: CustomText(
                                    '(${formateLatitudeLongitude(latitude!)}, ${formateLatitudeLongitude(longitude!)})',
                                    color: ColorUtils.black,
                                  ),
                                ),
                                    // if (widget.latitude != null && widget.longitude != null &&
                                    //     (widget.latitude != 0 || widget.longitude != 0))
                                    //   Padding(
                                    //     padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                    //     child: CustomText(
                                    //       '(${formateLatitudeLongitude(widget.latitude!)}, '
                                    //           '${formateLatitudeLongitude(widget.longitude!)})',
                                    //       color: ColorUtils.black,
                                    //     ),
                                    //   ),
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 120.w,
                        child: InkWell(
                          onTap: () {
                            // Get.dialog(
                            //   AlertDialog(
                            //     title: SizedBox(
                            //       height: googleController.locationList.isNotEmpty?null:80.h,
                            //       child: Column(
                            //         children: [
                            //           googleController.locationList.isNotEmpty
                            //               ? Column(
                            //             crossAxisAlignment: CrossAxisAlignment.start,
                            //             children: [
                            //               SizedBox(
                            //                 height: 150.h,
                            //                 child: ListView.builder(
                            //                   itemCount: googleController.locationList.length,
                            //                   itemBuilder: (context, index) {
                            //                     return CustomText(
                            //                       googleController.locationList[index],
                            //                       color: ColorUtils.black,
                            //                     );
                            //                   },
                            //                 ),
                            //               ),
                            //               SizedBox(
                            //                 height: 10.h,
                            //               ),
                            //               const Divider(),
                            //               InkWell(
                            //                 onTap: () {
                            //                   googleController.clearLocationList();
                            //                   sunriseSunsetController.clearLocationData();
                            //                   _clearData();
                            //                   sunriseSunsetController.weather.value = null;
                            //                   widget.latitude = 0;
                            //                   widget.longitude = 0;
                            //                   widget.address = '';
                            //                   setState(() {});
                            //                   Get.back(result: false);
                            //                 },
                            //                 child: const CustomText(
                            //                   'Delete All Location',
                            //                   color: ColorUtils.black,
                            //                 ),
                            //               ),
                            //               SizedBox(
                            //                 height: 10.h,
                            //               ),
                            //               const Divider(),
                            //               InkWell(
                            //                 onTap: () {
                            //                   Get.back();
                            //                   Get.dialog(
                            //                     AlertDialog(
                            //                       title: SizedBox(
                            //                         height: 100.h,
                            //                         child: Column(
                            //                           children: [
                            //                             InkWell(
                            //                               onTap: () {
                            //                                 Get.off( MapDemo());
                            //                               },
                            //                               child: const CustomText(
                            //                                 StringUtils.usgMapTxt,
                            //                                 color: ColorUtils.black,
                            //                               ),
                            //                             ),
                            //                             SizedBox(
                            //                               height: 20.h,
                            //                             ),
                            //                             InkWell(
                            //                               onTap: () {
                            //                                 // sunriseSunsetController.isLoad.value = true;
                            //                                 Get.off(const LocationScreen());
                            //                                 // sunriseSunsetController.isLoad.value = true;
                            //                               },
                            //                               child:const CustomText(
                            //                                 StringUtils.usgManuallyTxt,
                            //                                 color: ColorUtils.black,
                            //                               ),
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   );
                            //                 },
                            //                 child: const CustomText(
                            //                   'Add Location',
                            //                   color: ColorUtils.black,
                            //                 ),
                            //               ),
                            //             ],
                            //           )
                            //               : Column(
                            //             crossAxisAlignment: CrossAxisAlignment.start,
                            //             children: [
                            //               InkWell(
                            //                 onTap: () {
                            //                   Get.off( MapDemo());
                            //                 },
                            //                 child: const CustomText(
                            //                   StringUtils.usgMapTxt,
                            //                   color: ColorUtils.black,
                            //                 ),
                            //               ),
                            //               SizedBox(height: 10.h,),
                            //               const Divider(),
                            //               SizedBox(height: 10.h,),
                            //               InkWell(
                            //                 onTap: () {
                            //                   //sunriseSunsetController.isLoad.value = true;
                            //                   Get.off(const LocationScreen());
                            //                   // sunriseSunsetController.isLoad.value = false;
                            //
                            //                 },
                            //                 child:const CustomText(
                            //                   StringUtils.usgManuallyTxt,
                            //                   color: ColorUtils.black,
                            //                 ),
                            //               ),
                            //
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // );
                            _showLocationDialog();
                          },
                          child: Container(
                            width: 50.29.w,
                            height: 50.29.h,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorUtils.gridentColor1,
                                  ColorUtils.gridentColor2,
                                ],
                                begin: AlignmentDirectional.topEnd,
                                end: AlignmentDirectional.bottomEnd,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              AssetUtils.locationIcon,
                              color: ColorUtils.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //EDIT LOCATION
                  IconButton(
                      onPressed: () {
                        int index = 0;
                        Get.dialog(
                          AlertDialog(
                            title: SizedBox(
                              height: 120.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      // Delete this Location button pressed
                                      await _clearData(); // Clear stored data
                                      sunriseSunsetController.clearLocationData(); // Clear location data in the controller
                                      setState(() {
                                        address = ''; // Clear the address
                                        latitude = 0; // Clear the latitude
                                        longitude = 0;// Clear the longitude
                                        googleController.locationList.removeAt(index);
                                      });
                                      Get.back(); // Close the dialog
                                    },
                                      child: CustomText(
                                          'Delete this Location',
                                        fontWeight: FontWeight.w500,
                                        color: ColorUtils.black,
                                      ),
                                  ),
                                  Divider(),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      // String newAddress = widget.address ?? '';
                                      // double? newLatitude = widget.latitude;
                                      // double? newLongitude = widget.longitude;
                                      String newAddress = address ?? '';
                                      double? newLatitude = latitude;
                                      double? newLongitude = longitude;

                                       Get.dialog(
                                           AlertDialog(
                                            title: const CustomText(
                                              'Enter new name for location',
                                              color: ColorUtils.black,
                                            ),
                                            content: CommonTextField(
                                              initialValue: newAddress,

                                              onChange: (value) {
                                                newAddress = value;
                                              },
                                            ),
                                            actions: [
                                              Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                      },
                                                    child: CustomText(
                                                      'CANCEL',
                                                      color: ColorUtils.black,
                                                    ),
                                                  ),
                                                  TextButton(
                                                      onPressed: () async {
                                                        List locations = await locationFromAddress(newAddress);
                                                        if (locations.isNotEmpty) {
                                                          newLatitude = locations.first.latitude;
                                                          newLongitude = locations.first.longitude;
                                                        }
                                                        setState(() {
                                                          // widget.address = newAddress;
                                                          // widget.latitude = newLatitude;
                                                          // widget.longitude = newLongitude;
                                                          // googleController.locationList[index] = newAddress;
                                                          address = newAddress;
                                                          latitude = newLatitude;
                                                         longitude = newLongitude;
                                                          googleController.locationList[index] = newAddress;
                                                        });
                                                        // if (widget.address != null && widget.latitude != null && widget.longitude != null) {
                                                        //   PrefServices.setValue('address', widget.address!);
                                                        //   PrefServices.setValue('latitude', widget.latitude!);
                                                        //   PrefServices.setValue('longitude', widget.longitude!);
                                                        //   await PrefServices.setValue('locationList', googleController.locationList);
                                                        // }
                                                        if (address != null && latitude != null && longitude != null) {
                                                          PrefServices.setValue('address', address!);
                                                          PrefServices.setValue('latitude', latitude!);
                                                          PrefServices.setValue('longitude', longitude!);
                                                          await PrefServices.setValue('locationList', googleController.locationList);
                                                        }
                                                        Get.back();
                                                      },
                                                      child: CustomText(
                                                        'RENAME LOCATION',
                                                        color: ColorUtils.black,
                                                      )
                                                  ),
                                                ],
                                              ),

                                            ],
                                          )
                                       );
                                    },
                                    child: CustomText(
                                      'Rename this Location',
                                      fontWeight: FontWeight.w500,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        AssetUtils.seetingIcon,
                        size: 25.sp,
                        color: ColorUtils.white,
                      ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
      ),
    );
  }
  void _showLocationDialog() {
    Get.dialog(
      AlertDialog(
        title: SizedBox(
          height: googleController.locationList.isNotEmpty ? null : 120.h,
          child: Column(
            children: [
              googleController.locationList.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.h,
                    child: ListView.builder(
                      itemCount: googleController.locationList.length,
                      itemBuilder: (context, index) {
                        return CustomText(
                          googleController.locationList[index],
                          color: ColorUtils.black,
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  TextButton(
                      onPressed: () {
                        int index = 0;
                        googleController.clearLocationList();
                        sunriseSunsetController.clearLocationData();
                        _clearData();
                        sunriseSunsetController.weather.value = null;
                        // widget.latitude = 0;
                        // widget.longitude = 0;
                        // widget.address = '';
                        latitude = 0;
                        longitude = 0;
                       address = '';
                        setState(() {
                        });
                        Get.back(result: false);
                      },
                      child:  const CustomText(
                        StringUtils.deleteLocationTxt,
                        color: ColorUtils.black,
                      ),
                  ),
                  const Divider(),
                  TextButton(
                      onPressed: () {
                        Get.back();
                        Get.dialog(
                          AlertDialog(
                            title: SizedBox(
                              height: 120.h,
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.off(MapDemo());
                                    },
                                    child: const CustomText(
                                      StringUtils.usgMapTxt,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.off(const LocationScreen());

                                    },
                                    child: const CustomText(
                                      StringUtils.usgManuallyTxt,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child:  const CustomText(
                        StringUtils.addLocationTxt,
                        color: ColorUtils.black,
                      ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //     Get.dialog(
                  //       AlertDialog(
                  //         title: SizedBox(
                  //           height: 100.h,
                  //           child: Column(
                  //             children: [
                  //               TextButton(
                  //                   onPressed: () {
                  //                     Get.off(MapDemo());
                  //                   },
                  //                 child: const CustomText(
                  //                   StringUtils.usgMapTxt,
                  //                   color: ColorUtils.black,
                  //                 ),
                  //               ),
                  //               TextButton(
                  //                   onPressed: () {
                  //                     Get.off(const LocationScreen());
                  //
                  //                   },
                  //                   child: const CustomText(
                  //                     StringUtils.usgManuallyTxt,
                  //                     color: ColorUtils.black,
                  //                   ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: const CustomText(
                  //     StringUtils.addLocationTxt,
                  //     color: ColorUtils.black,
                  //   ),
                  // ),
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.off(MapDemo());
                    },
                    child: const CustomText(
                      StringUtils.usgMapTxt,
                      color: ColorUtils.black,
                    ),
                  ),

                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Get.off(const LocationScreen());

                    },
                    child: const CustomText(
                      StringUtils.usgManuallyTxt,
                      color: ColorUtils.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
