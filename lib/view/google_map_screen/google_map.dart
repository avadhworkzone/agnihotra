import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
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
                            height: 50.h,
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
