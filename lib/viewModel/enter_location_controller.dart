import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/view/google_map_screen/integrate_google_map.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';

class LocationController extends GetxController {
  GoogleController googleController = Get.find<GoogleController>();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  final validationFormKey = GlobalKey<FormState>();
  RxString address = ''.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxDouble latData = 0.0.obs;
  RxDouble lonData = 0.0.obs;
  RxBool isLoad = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    googleController.locationList.value = PrefServices.getStringList('locationList');
  }

  void getLatLongLocation() async {
    try {
      if (validationFormKey.currentState!.validate()){
        isLoad.value = true;
        latData.value = double.parse(latitudeController.text);
        lonData.value = double.parse(longitudeController.text);

        List<Placemark> placemarks = await placemarkFromCoordinates(latData.value, lonData.value);
        String street = placemarks[0].street ?? '';
        String subLocality = placemarks[0].subLocality ?? '';
        String locality = placemarks[0].locality ?? '';
        String administrativeArea = placemarks[0].administrativeArea ?? '';
        String postalCode = placemarks[0].postalCode ?? '';
        String country = placemarks[0].country ?? '';

        List<String> addressComponents = [
          street,
          subLocality,
          locality,
          administrativeArea,
          postalCode,
          country
        ];

        address.value = addressComponents.where((element) => element.isNotEmpty).join(', ');

        latitude.value = double.parse(latitudeController.text);
        longitude.value = double.parse(longitudeController.text);


        googleController.locationList.add(address.value);
        PrefServices.setValue('locationList', googleController.locationList);
        print("Manually Add===> ${address.value}");

        PrefServices.setValue('currentAddress',address.value);
        PrefServices.setValue('currentLat',latitude.value);
          PrefServices.setValue('currentLong',longitude.value);

        Get.offAll(
          SunriseSunetScreen(
            latitude: latitude.value,
            longitude: longitude.value,
            address: address.value,
            value: true,
          ),
        );
        isLoad.value = false;
        update();
        latitudeController.clear();
        longitudeController.clear();
      }
    } catch (e) {
      print('Error: $e');
      isLoad.value = false;
    }
  }


  void getLocationOnMap() async {
    try {
      if (validationFormKey.currentState!.validate()){
        latData.value = double.parse(latitudeController.text);
        lonData.value =double.parse(longitudeController.text);

        List<Placemark> placemarks = await placemarkFromCoordinates(latData.value, lonData.value);
        String street = placemarks[0].street ?? '';
        String subLocality = placemarks[0].subLocality ?? '';
        String locality = placemarks[0].locality ?? '';
        String administrativeArea = placemarks[0].administrativeArea ?? '';
        String postalCode = placemarks[0].postalCode ?? '';
        String country = placemarks[0].country ?? '';

        List<String> addressComponents = [
          street,
          subLocality,
          locality,
          administrativeArea,
          postalCode,
          country
        ];
        address.value = addressComponents.where((element) => element.isNotEmpty).join(', ');
        latitude.value = double.parse(latitudeController.text);
        longitude.value = double.parse(longitudeController.text);

        LatLng latLng = LatLng(latData.value, lonData.value);
        googleController.onAddMarkerButtonPressed(latLng);

        Get.to(
          IntegrateGoogleMap(
            latitude: latitude.value,
            longitude: longitude.value,
            address: address.value,
          ),
        );
        update();
        latitudeController.clear();
        longitudeController.clear();
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

