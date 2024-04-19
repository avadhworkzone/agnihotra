import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/google_map_screen/change_timezone_scrren.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';

class GoogleController extends GetxController {


  final TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  final RxSet<Marker> markers = <Marker>{}.obs;
  Rx<LatLng?> lastMapPosition = Rx<LatLng?>(null);
  Rx<MapType> currentMapType = MapType.hybrid.obs;
  RxString address = ''.obs;
  RxString searchAddress = ''.obs;
  RxBool isLoad = false.obs;
  RxBool result = true.obs;
  RxList<String> searchResultAddresses = <String>[].obs;
  RxList<double> searchResultLatitudes = <double>[].obs;
  RxList<double> searchResultLongitudes = <double>[].obs;
  RxList<String> locationList = <String>[].obs;
  RxList<String> suggestions = <String>[].obs;
  RxList<Map<String, dynamic>> locationLis = <Map<String, dynamic>>[].obs;

  late List<String> countryStateName = [];
  TextEditingController searchCountryController = TextEditingController();
  List<String> filteredCountryStateName = [];




  @override
  Future<void> onInit() async {
    super.onInit();
    address.value = PrefServices.getString('lastAddress');
    locationList.value = PrefServices.getStringList('locationList');
  }





  Future<String> onAddMarkerButtonPressed(LatLng latLng) async {
    print('===========>$markers');
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
          onMarkerTapped(latLng);
        },
      ),
    );
    moveCameraToLocation(latLng, 8.0);
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      String street = placeMarks.isNotEmpty ? placeMarks[0].street ?? '' : '';
      String subLocality =
          placeMarks.isNotEmpty ? placeMarks[0].subLocality ?? '' : '';
      String locality =
          placeMarks.isNotEmpty ? placeMarks[0].locality ?? '' : '';
      String administrativeArea =
          placeMarks.isNotEmpty ? placeMarks[0].administrativeArea ?? '' : '';
      String postalCode =
          placeMarks.isNotEmpty ? placeMarks[0].postalCode ?? '' : '';
      String country = placeMarks.isNotEmpty ? placeMarks[0].country ?? '' : '';

      List<String> addressComponents = [
        street,
        subLocality,
        locality,
        administrativeArea,
        postalCode,
        country,
      ];
      address.value = addressComponents.where((element) => element.isNotEmpty).join(', ');
      address.value = address.value;
      lastMapPosition.value = LatLng(
        latLng.latitude,
        latLng.longitude,
      );
      address.value = address.value;
      update();
      return address.value;
    } catch (e) {
      print("Error getting placemark: $e");
      return address.value;
    }
  }

  onCameraMove(CameraPosition position) {
    lastMapPosition.value = position.target;
  }

  onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
    mapController = controller;
  }

  onMarkerTapped(LatLng latLng) {
    onAddMarkerButtonPressed(latLng);
  }

  Future<String> searchLocations(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);

      suggestions.clear();

      searchResultAddresses.clear();
      searchResultLatitudes.clear();
      searchResultLongitudes.clear();

      markers.clear();

      for (var location in locations) {
        List<Placemark> placeMarks = await placemarkFromCoordinates(
            location.latitude, location.longitude);

        String street = placeMarks.isNotEmpty ? placeMarks[0].street ?? '' : '';
        String subLocality =
            placeMarks.isNotEmpty ? placeMarks[0].subLocality ?? '' : '';
        String locality =
            placeMarks.isNotEmpty ? placeMarks[0].locality ?? '' : '';
        String administrativeArea =
            placeMarks.isNotEmpty ? placeMarks[0].administrativeArea ?? '' : '';
        String postalCode =
            placeMarks.isNotEmpty ? placeMarks[0].postalCode ?? '' : '';
        String country =
            placeMarks.isNotEmpty ? placeMarks[0].country ?? '' : '';

        List<String> addressComponents = [
          street,
          subLocality,
          locality,
          administrativeArea,
          postalCode,
          country,
        ];

        searchAddress.value =
            addressComponents.where((element) => element.isNotEmpty).join(', ');
        address.value = searchAddress.value;

        searchResultAddresses.add(searchAddress.value);
        searchResultLatitudes.add(location.latitude);
        searchResultLongitudes.add(location.longitude);

        moveCameraToLocation(LatLng(location.latitude, location.longitude), 8.0);

        markers.add(
          Marker(
            markerId: MarkerId(location.toString()),
            position: LatLng(location.latitude, location.longitude),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              onMarkerTapped(LatLng(location.latitude, location.longitude));
            },
          ),
        );

        lastMapPosition.value = LatLng(
          location.latitude,
          location.longitude,
        );
        address.value = searchAddress.value;
        suggestions.add(searchAddress.value);
      }
      update();
      return searchAddress.value;
    } catch (e) {
      print("Error searching locations: $e");
      return searchAddress.value;
    }
  }

  Future<void> onSearch(String query) async {
    try {
      await searchLocations(query);
      suggestions.addAll(searchResultAddresses);
    } catch (e) {
      print("Error searching locations: $e");
    }
  }

  void onSuggestionSelected(String suggestion) {
    searchController.text = suggestion;
    searchResultAddresses.clear();
    searchResultLatitudes.clear();
    searchResultLongitudes.clear();
    suggestions.clear();
  }

  moveCameraToLocation(LatLng location, double zoom) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(location, zoom),
    );
  }

  void clearLocationList() async {
    locationList.clear();
    await PrefServices.setValue("locationList", locationList);
    print("===========$locationList");
    update();
  }

  toggleMapType() {

    if (currentMapType.value == MapType.hybrid){
      currentMapType.value = MapType.normal;
       print("normal View==============");
    } else {
      currentMapType.value = MapType.hybrid;
      print("satellite View==============");

    }

  }

  Future<String> loadJsonFromAsset(String assetPath) async {
    return await rootBundle.loadString(assetPath);
  }

  onLocationData(String addr, double lati, double long) async {
    address.value = addr;

    print("=======> Address :- ${address.value}");
    print("==> Lat long :- $lati $long");
    locationList.add(address.value);
    print('======LocationList=========> $locationList');
    await PrefServices.setValue('locationList', locationList);

    if(address.value.isNotEmpty){
      Get.offAll(
        SunriseSunetScreen(
          latitude: lati,
          longitude: long,
          address: address.value,
          value: true,
        ),
      );
      confirmTimeZone();
    }

  }


  Future<void> confirmTimeZone() async {
    return Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.r), // Change border radius
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(
              height: 11.h,
            ),

            CustomText(
              StringUtils.timeZonTxt,
              fontWeight: FontWeight.w600,
              color: ColorUtils.black,
              textAlign: TextAlign.center,
              fontSize: 15.sp,
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomText(
              StringUtils.standardTime,
              fontWeight: FontWeight.w500,
              color: ColorUtils.black,
              textAlign: TextAlign.center,
              fontSize: 13.sp,
            ),

            SizedBox(
              height: 10.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                InkWell(
                  onTap: () {
                    Get.off(const ChangeTimeZoneScreen());
                    print("======= CHANGE TIME ZONE SCREEN========");
                  },
                  child: CustomText(
                    StringUtils.changeTimeTxt,
                    fontWeight: FontWeight.w600,
                    color: ColorUtils.orange,
                    textAlign: TextAlign.center,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),

                /// Confirm Button
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: CustomBtn(
                    height: 26.h,
                    width: 81.w,
                    gradient: const LinearGradient(
                      colors: [
                        ColorUtils.gridentColor1,
                        ColorUtils.gridentColor2,
                      ],
                      begin: AlignmentDirectional.topEnd,
                      end: AlignmentDirectional.bottomEnd,
                    ),
                    onTap: (){
                      Get.back();
                    },
                    title: StringUtils.confirmTxt,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 16.h,
            ),

          ],
        ),
      ));


  }



}
