// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:get/get.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:sunrise_app/commonWidget/common_container.dart';
// // import 'package:sunrise_app/commonWidget/common_text.dart';
// // import 'package:sunrise_app/utils/color_utils.dart';
// // import 'package:sunrise_app/utils/string_utils.dart';
// // import 'package:sunrise_app/viewModel/google_map_controller.dart';
// //
// // class MapDemo extends StatefulWidget {
// //   const MapDemo({Key? key, this.latitude, this.longitude, this.address}):super(key: key);
// //
// //   final double? latitude;
// //   final double? longitude;
// //   final String? address;
// //
// //
// //   @override
// //   State<MapDemo> createState() => _MapDemoState();
// // }
// // class _MapDemoState extends State<MapDemo> {
// //   @override
// //   GoogleController googleController = Get.find<GoogleController>();
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     _getLocation();
// //
// //   }
// //   _getLocation() async {
// //     try {
// //       googleController.isLoad = true;
// //       print('==========>');
// //       Position currentPosition = await Geolocator.getCurrentPosition(
// //           desiredAccuracy: LocationAccuracy.low,
// //           forceAndroidLocationManager: false
// //         //  desiredAccuracy: LocationAccuracy.,
// //       );
// //
// //       googleController.lastMapPosition = LatLng(
// //         currentPosition.latitude,
// //         currentPosition.longitude,
// //       );
// //       googleController.onAddMarkerButtonPressed(googleController.lastMapPosition!);
// //       print('==========>${googleController.isLoad}');
// //       googleController.isLoad = false;
// //     } catch (e) {
// //       print("Error getting current location: $e");
// //     }
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: GetBuilder<GoogleController>(
// //         builder: (controller) =>
// //             controller.isLoad ? Center(child: CircularProgressIndicator()): Column(
// //           children: [
// //             commonContainer(
// //               height: 850.h,
// //               child: GoogleMap(
// //                 onMapCreated: controller.onMapCreated,
// //                 initialCameraPosition: CameraPosition(
// //                   target:  controller.lastMapPosition!,
// //                   zoom: 11.0,
// //                 ),
// //                 mapType: controller.currentMapType,
// //                 markers: controller.markers,
// //                 onCameraMove: controller.onCameraMove,
// //                 onTap: (LatLng latLng) {
// //                   controller.onAddMarkerButtonPressed(latLng);
// //                 },
// //               ),
// //             ),
// //             commonContainer(
// //               height: 208.h,
// //               decoration: const BoxDecoration(
// //                 color: ColorUtils.mapContColor,
// //               ),
// //               alignment: Alignment.centerLeft,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   SizedBox(height: 8.h),
// //                   Padding(
// //                     padding: EdgeInsets.only(left: 10.w),
// //                     child: CustomText(
// //                       'Address: ${controller.address}',
// //
// //                       color: ColorUtils.black,
// //                     ),
// //                   ),
// //                   SizedBox(height: 8.h),
// //                   Padding(
// //                     padding: EdgeInsets.only(left: 10.w),
// //                     child: CustomText(
// //                       'Latitude: ${controller.lastMapPosition!.latitude}',
// //
// //                       color: ColorUtils.black,
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: EdgeInsets.only(left: 10.w),
// //                     child: CustomText(
// //                       'Longitude: ${controller.lastMapPosition!.longitude}',
// //                       color: ColorUtils.black,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     height: 20.h,
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Padding(
// //                         padding: EdgeInsets.only(left: 10.w),
// //                         child: GestureDetector(
// //                           onTap: () {
// //                             controller.onLocationData();
// //                           },
// //                           child: commonContainer(
// //                             width: 80.w,
// //                             height: 60.h,
// //                             alignment: Alignment.center,
// //                             decoration: const BoxDecoration(
// //                               color: ColorUtils.selectBtnColor,
// //                             ),
// //                             child: const CustomText(
// //                               StringUtils.selectTxt,
// //                               color: ColorUtils.black,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       Padding(
// //                         padding: EdgeInsets.only(right: 10.w),
// //                         child: commonContainer(
// //                           width: 80.w,
// //                           height: 60.h,
// //                           alignment: Alignment.center,
// //                           decoration: const BoxDecoration(
// //                             color: ColorUtils.selectBtnColor,
// //                           ),
// //                           child: const CustomText(
// //                             StringUtils.mapTxt,
// //                             color: ColorUtils.black,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sunrise_app/commonWidget/common_container.dart';
// import 'package:sunrise_app/commonWidget/common_text.dart';
// import 'package:sunrise_app/utils/color_utils.dart';
// import 'package:sunrise_app/utils/string_utils.dart';
// import 'package:sunrise_app/viewModel/google_map_controller.dart';
//
// class MapDemo extends StatefulWidget {
//   const MapDemo({Key? key, this.latitude, this.longitude, this.address}) : super(key: key);
//
//   final double? latitude;
//   final double? longitude;
//   final String? address;
//
//   @override
//   State<MapDemo> createState() => _MapDemoState();
// }
//
// class _MapDemoState extends State<MapDemo> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<GoogleController>(
//         builder: (controller) {
//           if (controller.lastMapPosition == null) {
//             return Center(child: CircularProgressIndicator()); // Loading indicator
//           }
//          return Column(
//             children: [
//               commonContainer(
//                 height: 850.h,
//                 child: GoogleMap(
//                   onMapCreated: controller.onMapCreated,
//                   initialCameraPosition: CameraPosition(
//                     target: controller.lastMapPosition!,
//                     zoom: 11.0,
//                   ),
//                   mapType: controller.currentMapType,
//                   markers: controller.markers,
//                   onCameraMove: controller.onCameraMove,
//                   onTap: (LatLng latLng) {
//                     controller.onAddMarkerButtonPressed(latLng);
//                   },
//                 ),
//               ),
//               commonContainer(
//                 height: 208.h,
//                 decoration: const BoxDecoration(
//                   color: ColorUtils.mapContColor,
//                 ),
//                 alignment: Alignment.centerLeft,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 8.h),
//                     Padding(
//                       padding: EdgeInsets.only(left: 10.w),
//                       child: CustomText(
//                         'Address: ${widget.address ?? controller.address}',
//                         color: ColorUtils.black,
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Padding(
//                       padding: EdgeInsets.only(left: 10.w),
//                       child: CustomText(
//                         'Latitude: ${widget.latitude ?? controller.lastMapPosition?.latitude }',
//                         color: ColorUtils.black,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 10.w),
//                       child: CustomText(
//                         'Longitude: ${widget.latitude ?? controller.lastMapPosition?.longitude}',
//                         color: ColorUtils.black,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 10.w),
//                           child: GestureDetector(
//                             onTap: () {
//                               controller.onLocationData();
//                             },
//                             child: commonContainer(
//                               width: 80.w,
//                               height: 60.h,
//                               alignment: Alignment.center,
//                               decoration: const BoxDecoration(
//                                 color: ColorUtils.selectBtnColor,
//                               ),
//                               child: const CustomText(
//                                 StringUtils.selectTxt,
//                                 color: ColorUtils.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(right: 10.w),
//                           child: commonContainer(
//                             width: 80.w,
//                             height: 60.h,
//                             alignment: Alignment.center,
//                             decoration: const BoxDecoration(
//                               color: ColorUtils.selectBtnColor,
//                             ),
//                             child: const CustomText(
//                               StringUtils.mapTxt,
//                               color: ColorUtils.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_container.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';

class MapDemo extends StatefulWidget {
  MapDemo({Key? key, this.latitude, this.longitude, this.address})
      : super(key: key);

  double? latitude;
  double? longitude;
  String? address;

  @override
  State<MapDemo> createState() => _MapDemoState();
}

class _MapDemoState extends State<MapDemo> {
  final GoogleController googleController = Get.find<GoogleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (googleController.lastMapPosition == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [

              Column(
                children: [
                  Container(
                    height: 550.h,
                    child: GoogleMap(
                      onMapCreated: googleController.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: googleController.lastMapPosition.value ?? const LatLng(0.0, 0.0),
                        zoom: 11.0,
                      ),
                      mapType: googleController.currentMapType.value,
                      markers: googleController.markers,
                      onCameraMove: googleController.onCameraMove,
                      onTap: (LatLng latLng) async {
                        await googleController.onAddMarkerButtonPressed(latLng);
                        print('lastaddress===>${googleController.address}');
                        widget.latitude  = googleController.lastMapPosition.value?.latitude;
                        widget.longitude = googleController.lastMapPosition.value?.longitude;
                        widget.address   = googleController.address.value;
                        setState(() {});
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: CustomText(
                            'Address: ${widget.address ?? googleController.address.value}',
                            fontSize: 16.sp,
                            color: ColorUtils.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: CustomText(
                            'Latitude: ${widget.latitude ?? googleController.lastMapPosition.value?.latitude}',
                            fontSize: 16.sp,
                            color: ColorUtils.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: CustomText(
                            'Longitude: ${widget.longitude ?? googleController.lastMapPosition.value?.longitude}',
                            fontSize: 16.sp,
                            color: ColorUtils.black,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w,right: 200.w),
                          child: CustomBtn(
                            gradient: const LinearGradient(
                              colors: [
                                ColorUtils.gridentColor1,
                                ColorUtils.gridentColor2,
                              ],
                              begin: AlignmentDirectional.topEnd,
                              end: AlignmentDirectional.bottomEnd,
                            ),
                            onTap: () {
                              googleController.onLocationData(
                                widget.address ?? googleController.address.value,
                                widget.latitude ?? googleController.lastMapPosition.value!.latitude,
                                widget.longitude ?? googleController.lastMapPosition.value!.longitude,
                              );
                            },
                            title: StringUtils.mapTxt,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
