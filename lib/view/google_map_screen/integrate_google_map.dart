import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/viewModel/enter_location_controller.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';

class IntegrateGoogleMap extends StatefulWidget {
  double? latitude;
  double? longitude;
  String? address;

  IntegrateGoogleMap({Key? key, this.latitude, this.longitude, this.address})
      : super(key: key);

  @override
  State<IntegrateGoogleMap> createState() => _IntegrateGoogleMapState();
}

const kGoogleApiKey = 'AIzaSyCotiIYalOfFMwIsvVPhwnFEGxPX-CtyYo';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _IntegrateGoogleMapState extends State<IntegrateGoogleMap> {
  final GoogleController googleController = Get.find<GoogleController>();
  LocationController locationController = Get.find<LocationController>();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    if (widget.latitude != null && widget.longitude != null) {
      LatLng latLng = LatLng(widget.latitude!, widget.longitude!);
      googleController.onAddMarkerButtonPressed(latLng);
    }

    widget.latitude = locationController.currentLat;
    widget.longitude = locationController.currentLong;
    widget.address = locationController.currentAddress;

    print(
        "Init widget.longitude ===========>${widget.longitude} ${widget.latitude}");

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (googleController.lastMapPosition == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                          onTap: () {
                            onSearch();
                          },
                          leading: const Icon(
                            AssetUtils.searchIcon,
                          ),
                          title: const CustomText(
                            StringUtils.searchText,
                            color: ColorUtils.black,
                          )),
                    ),
                  ],
                ),
                Obx(() => SizedBox(
                      height: Get.height / 1.5,
                      child: GoogleMap(
                        markers: googleController.markers,
                        onMapCreated: googleController.onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              widget.latitude ?? 0.0, widget.longitude ?? 0.0),
                          zoom: 10.0,
                        ),
                        mapType: googleController.currentMapType.value,
                        onCameraMove: googleController.onCameraMove,
                        onTap: (LatLng latLng) async {
                          Marker marker =
                              _buildMarker(latLng, 'Custom Place Name');
                          setState(() {
                            googleController.markers.add(marker);
                          });

                          await googleController
                              .onAddMarkerButtonPressed(latLng);

                          googleController.lastMapPosition.value = latLng;

                          widget.latitude =
                              googleController.lastMapPosition.value?.latitude;

                          widget.longitude =
                              googleController.lastMapPosition.value?.longitude;
                          widget.address = googleController.address.value;
                          setState(() {});
                        },
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),

                    /// Address
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: CustomText(
                        'Address: ${widget.address}',
                        fontSize: 16.sp,
                        color: ColorUtils.black,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    ///Latitude
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: CustomText(
                        'Latitude: ${widget.latitude}',
                        fontSize: 16.sp,
                        color: ColorUtils.black,
                      ),
                    ),

                    ///Longitude
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: CustomText(
                        'Longitude: ${widget.longitude}',
                        fontSize: 16.sp,
                        color: ColorUtils.black,
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        /// SELECT BUTTON
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: CustomBtn(
                            height: 45.h,
                            width: 100.w,
                            gradient: const LinearGradient(
                              colors: [
                                ColorUtils.gridentColor1,
                                ColorUtils.gridentColor2,
                              ],
                              begin: AlignmentDirectional.topEnd,
                              end: AlignmentDirectional.bottomEnd,
                            ),
                            onTap: () async {

                              PrefServices.setValue(
                                  'currentAddress', widget.address);

                              PrefServices.setValue(
                                  'currentLat',
                                  googleController
                                      .lastMapPosition.value!.latitude);

                              PrefServices.setValue(
                                  'currentLong',
                                  googleController
                                      .lastMapPosition.value!.longitude);


                              PrefServices.setValue('countryName','India Standard Time');

                              googleController.addLocation(
                                widget.address ??
                                    googleController.address.value,
                                widget.latitude ??
                                    googleController
                                        .lastMapPosition.value!.latitude,
                                widget.longitude ??
                                    googleController
                                        .lastMapPosition.value!.longitude,
                              );
                            },
                            title: StringUtils.selectTxt,
                            fontSize: 15.sp,
                          ),
                        ),

                        const Spacer(),

                        /// Map View and Satalite view
                        Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: CustomBtn(
                            height: 45.h,
                            width: 100.w,
                            gradient: const LinearGradient(
                              colors: [
                                ColorUtils.gridentColor1,
                                ColorUtils.gridentColor2,
                              ],
                              begin: AlignmentDirectional.topEnd,
                              end: AlignmentDirectional.bottomEnd,
                            ),
                            onTap: () {
                              googleController.toggleMapType();
                              print(
                                  "googleController.currentMapType.value :- ${googleController.currentMapType.value}");
                            },
                            title: googleController.currentMapType.value ==
                                    MapType.hybrid
                                ? StringUtils.mapViewTxt
                                : StringUtils.satelliteTxt,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> onSearch() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay,
      language: 'en',
      strictbounds: false,
      onError: onError,
      types: [""],
      decoration: InputDecoration(
        hintText: "Search",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: ColorUtils.white),
        ),
      ),
      components: [Component(Component.country, "in")],
    );
    displayPredction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Marker _buildMarker(LatLng position, String placeName) {
    return Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(
        title: placeName,
      ),
    );
  }

  Future<void> displayPredction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse details =
        await places.getDetailsByPlaceId(p.placeId!);
  }
}
