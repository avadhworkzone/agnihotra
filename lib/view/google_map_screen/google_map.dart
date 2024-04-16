import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
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
const kGoogleApiKey = 'AIzaSyCotiIYalOfFMwIsvVPhwnFEGxPX-CtyYo';
final homeScaffoldKey = GlobalKey<ScaffoldState>();
class _MapDemoState extends State<MapDemo> {

  final GoogleController googleController = Get.find<GoogleController>();

  @override
  void initState() {
    super.initState();
    if (widget.latitude != null && widget.longitude != null) {
      //Add marker for provided latitude and longitude
      LatLng latLng = LatLng(widget.latitude!, widget.longitude!);
      googleController.onAddMarkerButtonPressed(latLng);
    }
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
                // SizedBox(height: 30.h,),
                // Row(
                //   children: [
                //   Expanded(
                //     child: ListTile(
                //       onTap: () {
                //         onSearch();
                //       },
                //       leading: Icon(
                //         AssetUtils.searchIcon,
                //       ),
                //       title: CustomText(
                //         StringUtils.searchText,
                //         color: ColorUtils.black,
                //       )
                //     ),
                //   ),
                //   ],
                // ),
                SizedBox(
                  height: 500.h,
                  child: GoogleMap(
                   onMapCreated: googleController.onMapCreated,
                    initialCameraPosition: CameraPosition(
                    target: googleController.lastMapPosition.value ?? LatLng(widget.latitude ?? 0.0, widget.longitude ?? 0.0),
                    // target: LatLng(widget.latitude ?? 0.0, widget.longitude ?? 0.0),
                      zoom: 8.0,
                    ),
                    mapType: googleController.currentMapType.value,
                    markers: googleController.markers,
                    onCameraMove: googleController.onCameraMove,
                    onTap: (LatLng latLng) async {
                      await googleController.onAddMarkerButtonPressed(latLng);
                      print('========>lastaddress===>${googleController.address}');
                      googleController.lastMapPosition.value = latLng;
                      widget.latitude  = googleController.lastMapPosition.value?.latitude;
                      widget.longitude = googleController.lastMapPosition.value?.longitude;
                      widget.address   = googleController.address.value;
                      setState(() {});
                    },
                  ),
                ),
                Column(
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
                        onTap: () async {
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
              ],
            ),
          );
        },
      ),
    );
  }


  Future<void>onSearch()async{

    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay,
      language: 'en',
      strictbounds: false,
      onError:onError,
      types: [""],
      decoration: InputDecoration(
        hintText: "Search",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ColorUtils.white),
        ),
      ),
      components: [Component(Component.country, "in")],);
    displayPredction(p!,homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response){
    // homeScaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(response.errorMessage!),));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPredction(Prediction p,ScaffoldState?currentState)async{

    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse details = await places.getDetailsByPlaceId(p.placeId!);

    final lat = details.result.geometry!.location.lat;
    final lng = details.result.geometry!.location.lng;
  }
}
