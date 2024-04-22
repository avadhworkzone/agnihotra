import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class ChangeTimeZoneScreen extends StatefulWidget {
  const ChangeTimeZoneScreen({Key? key}) : super(key: key);

  @override
  _ChangeTimeZoneScreenState createState() => _ChangeTimeZoneScreenState();
}

class _ChangeTimeZoneScreenState extends State<ChangeTimeZoneScreen> {

  SunriseSunsetController sunriseSunsetController = Get.find<SunriseSunsetController>();

  GoogleController googleController = Get.find<GoogleController>();


  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    var locations = tz.timeZoneDatabase.locations;

    locations.forEach((key, value) {
      googleController.countryStateName.add(key);
    });


  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          CommonTextField(
            textEditController: googleController.searchCountryController,
            onChange: (value) {
              setState(() {
                googleController.filteredCountryStateName = googleController.countryStateName
                    .where((name) =>
                        name.toLowerCase().contains(value.toLowerCase()))
                    .toList();

              });
            },
            hintText: 'Search',
          ),

          SizedBox(
            height: 25.h,
          ),

          Expanded(
            child: ListView.separated(
              itemCount: googleController.searchCountryController.text.isNotEmpty
                  ? googleController.filteredCountryStateName.length
                  : googleController.countryStateName.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){

                    sunriseSunsetController.countryTimeZone(
                        PrefServices.getDouble('currentLat'),
                        PrefServices.getDouble('currentLong'),
                        sunriseSunsetController.formattedDate,
                        googleController.searchCountryController.text.isNotEmpty
                            ? googleController.filteredCountryStateName[index]
                            : googleController.countryStateName[index]
                    ).then((value){

                      setState(() {

                      PrefServices.setValue('countryName',googleController.searchCountryController.text.isNotEmpty
                          ? googleController.filteredCountryStateName[index]
                          : googleController.countryStateName[index]);
                      });

                      _isTimezoneConfirmDialog(googleController.searchCountryController.text.isNotEmpty
                          ? googleController.filteredCountryStateName[index]
                          : googleController.countryStateName[index]);

                    });



                  },

                  child: Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: CustomText(
                      textAlign: TextAlign.left,
                      googleController.searchCountryController.text.isNotEmpty
                          ? googleController.filteredCountryStateName[index]
                          : googleController.countryStateName[index],
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),

                );
              },

              separatorBuilder: (context, index){
                return Divider(
                  height: 15.h,
                  thickness: 1.h,
                );
              },

            ),
          ),
        ],
      ),
    );
  }

  void _isTimezoneConfirmDialog(String countryName){
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(3.r),borderSide: BorderSide.none),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              SizedBox(
                height: 10.h,
              ),
              CustomText(
                StringUtils.confirmTimeZone,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: ColorUtils.black,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomText(
                countryName,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: ColorUtils.black,
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                      googleController.searchCountryController.clear();
                    },
                    child: CustomText(
                      StringUtils.cancleTxt,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorUtils.orange,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),

                  /// Yes Button
                  InkWell(
                    onTap: (){
                     Get.to(SunriseSunetScreen());
                      googleController.searchCountryController.clear();
                    },
                    child: CustomText(
                      StringUtils.yesTxt,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorUtils.orange,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

}