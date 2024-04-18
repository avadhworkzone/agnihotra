import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class ChangeTimeZoneScreen extends StatefulWidget {
  const ChangeTimeZoneScreen({Key? key}) : super(key: key);

  @override
  _ChangeTimeZoneScreenState createState() => _ChangeTimeZoneScreenState();
}

class _ChangeTimeZoneScreenState extends State<ChangeTimeZoneScreen> {
  late List<String> countryStateName = [];
  TextEditingController timezoneController = TextEditingController();
  List<String> filteredCountryStateName = [];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    var locations = tz.timeZoneDatabase.locations;

    locations.forEach((key, value) {
      countryStateName.add(key);
    });

    filteredCountryStateName.addAll(countryStateName);
  }

  void filterCountryState(String query) {
    setState(() {
      filteredCountryStateName = countryStateName
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          // CommonTextField(
          //   textEditController: timezoneController,
          //   onChange: (value){
          //     filterCountryState(value);
          //   },
          //   hintText: 'Search',
          // ),
          SizedBox(
            height: 25.h,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredCountryStateName.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {

                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: CustomText(
                      textAlign: TextAlign.left,
                      filteredCountryStateName[index],
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 15.h,
                  thickness: 1.h,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
