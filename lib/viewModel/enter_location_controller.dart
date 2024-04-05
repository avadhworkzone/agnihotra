// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:sunrise_app/view/google_map_screen/google_map.dart';
// import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
//
//
// class LocationController extends GetxController {
//
//   TextEditingController latitudeController = TextEditingController();
//   TextEditingController longitudeController = TextEditingController();
//   String address = '';
//   String latitude = '';
//   String longitude = '';
//
//   getLocation() async {
//
//     String lat = latitudeController.text;
//     String lon = longitudeController.text;
//
//     try {
//
//       double latData = double.parse(lat);
//       double lonData = double.parse(lon);
//
//       List<Placemark> placemarks = await placemarkFromCoordinates(latData, lonData);
//       String street = placemarks[0].street ?? '';
//       String subLocality = placemarks[0].subLocality ?? '';
//       String locality = placemarks[0].locality ?? '';
//       String administrativeArea = placemarks[0].administrativeArea ?? '';
//       String postalCode = placemarks[0].postalCode ?? '';
//       String country = placemarks[0].country ?? '';
//
//       List<String> addressComponents = [
//         street,
//         subLocality,
//         locality,
//         administrativeArea,
//         postalCode,
//         country
//       ];
//       address = addressComponents.where((element) => element.isNotEmpty).join(', ');
//       //   address = '$street, $subLocality, $locality, $administrativeArea, $postalCode, $country';
//       latitude = lat;
//       longitude = lon;
//       update();
//
//       Get.to(
//         SunriseSunetScreen(
//           address: address,
//           latitude: double.parse(latitude),
//           longitude: double.parse(longitude),
//         ),
//       );
//       latitudeController.clear();
//       latitudeController.clear();
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   getLocationOnMap() async {
//
//     String lat = latitudeController.text;
//     String lon = longitudeController.text;
//
//     try {
//       double latData = double.parse(lat);
//       double lonData = double.parse(lon);
//
//       List<Placemark> placemarks = await placemarkFromCoordinates(latData, lonData);
//       String street = placemarks[0].street ?? '';
//       String subLocality = placemarks[0].subLocality ?? '';
//       String locality = placemarks[0].locality ?? '';
//       String administrativeArea = placemarks[0].administrativeArea ?? '';
//       String postalCode = placemarks[0].postalCode ?? '';
//       String country = placemarks[0].country ?? '';
//
//       List<String> addressComponents = [
//         street,
//         subLocality,
//         locality,
//         administrativeArea,
//         postalCode,
//         country
//       ];
//       address = addressComponents.where((element) => element.isNotEmpty).join(', ');
//       latitude = lat;
//       longitude = lon;
//       update();
//
//       Get.to(
//         MapDemo(
//           address: address,
//           latitude: double.parse(latitude),
//           longitude: double.parse(longitude),
//         ),
//       );
//       latitudeController.clear();
//       latitudeController.clear();
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/view/google_map_screen/google_map.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';


// class LocationController extends GetxController {
//
//   GoogleController googleController = Get.find<GoogleController>();
//   TextEditingController latitudeController = TextEditingController();
//   TextEditingController longitudeController = TextEditingController();
//   String address = '';
//   String latitude = '';
//   String longitude = '';
//
//   void getLocation() async {
//
//     String lat = latitudeController.text;
//     String lon = longitudeController.text;
//
//     try {
//
//       double latData = double.parse(lat);
//       double lonData = double.parse(lon);
//
//       List<Placemark> placemarks = await placemarkFromCoordinates(latData, lonData);
//       String street = placemarks[0].street ?? '';
//       String subLocality = placemarks[0].subLocality ?? '';
//       String locality = placemarks[0].locality ?? '';
//       String administrativeArea = placemarks[0].administrativeArea ?? '';
//       String postalCode = placemarks[0].postalCode ?? '';
//       String country = placemarks[0].country ?? '';
//
//       List<String> addressComponents = [
//         street,
//         subLocality,
//         locality,
//         administrativeArea,
//         postalCode,
//         country
//       ];
//       address = addressComponents.where((element) => element.isNotEmpty).join(', ');
//       //   address = '$street, $subLocality, $locality, $administrativeArea, $postalCode, $country';
//       latitude = lat;
//       longitude = lon;
//       update();
//
//       Get.to(
//         SunriseSunetScreen(
//           address: address,
//           latitude: double.parse(latitude),
//           longitude: double.parse(longitude),
//         ),
//       );
//     } catch (e) {
//       print('Error: $e');
//     }
//     googleController.locationList.add(address);
//   }
//   void clearLocationList() {
//     googleController.locationList.clear();
//     print("location is deleted");
//     update();
//   }
//
//   getLocationOnMap() async {
//
//     String lat = latitudeController.text;
//     String lon = longitudeController.text;
//
//     try {
//       double latData = double.parse(lat);
//       double lonData = double.parse(lon);
//
//       List<Placemark> placemarks = await placemarkFromCoordinates(latData, lonData);
//       String street = placemarks[0].street ?? '';
//       String subLocality = placemarks[0].subLocality ?? '';
//       String locality = placemarks[0].locality ?? '';
//       String administrativeArea = placemarks[0].administrativeArea ?? '';
//       String postalCode = placemarks[0].postalCode ?? '';
//       String country = placemarks[0].country ?? '';
//
//       List<String> addressComponents = [
//         street,
//         subLocality,
//         locality,
//         administrativeArea,
//         postalCode,
//         country
//       ];
//       address = addressComponents.where((element) => element.isNotEmpty).join(', ');
//       latitude = lat;
//       longitude = lon;
//       update();
//
//       Get.to(
//         MapDemo(
//           address: address,
//           latitude: double.parse(latitude),
//           longitude: double.parse(longitude),
//         ),
//       );
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }

class LocationController extends GetxController {
  GoogleController googleController = Get.find<GoogleController>();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  final validationFormKey = GlobalKey<FormState>();
  RxString address = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxDouble latData = 0.0.obs;
  RxDouble lonData = 0.0.obs;
  RxBool isLoad = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    googleController.locationList.value = PrefServices.getStringList('locationList');
  }

  void getLocation() async {
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

        latitude.value = latitudeController.text;
        longitude.value = longitudeController.text;

        PrefServices.setValue('lastAddress', address.value);
        googleController.locationList.add(address.value);
        await PrefServices.setValue('locationList', googleController.locationList);
        Get.offAll(
          SunriseSunetScreen(
            latitude: double.parse(latitude.value),
            longitude: double.parse(longitude.value),
            address: address.value,
            value: false,
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
  //
  // void clearLocationList() {
  //   googleController.locationList.clear();
  //   print("location is deleted");
  //   update();
  // }

  // void clearLocationList() async {
  //   googleController.locationList.clear();
  //   await PrefServices.setValue("locationList", googleController.locationList);
  //   update();
  // }

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
        latitude.value = latitudeController.text;
        longitude.value = longitudeController.text;
        Get.to(
          MapDemo(
            latitude: double.parse(latitude.value),
            longitude: double.parse(longitude.value),
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

