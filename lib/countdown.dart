import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app/services/prefServices.dart';

class CountDown extends StatefulWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {


  void date() {
    // Fetch the sunrise time from PrefServices or any source
    String? sunriseTime = PrefServices.getString('sunrise');

    // Get the current time
    DateTime currentTime = DateTime.now();

    // Check if sunriseTime is not null
    if (sunriseTime != null) {
      // Parse the sunriseTime string to DateTime object
      DateTime parsedSunriseTime = DateFormat('hh:mm:ss a').parse(sunriseTime);

      // Create a DateTime object combining the time with the current date
      DateTime sunriseDateTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        parsedSunriseTime.hour,
        parsedSunriseTime.minute,
        parsedSunriseTime.second,
      );

      // Calculate the difference between current time and sunrise time
      Duration difference = sunriseDateTime.difference(currentTime);

      // Print the difference
      print('Difference between current time and sunrise time: $difference');
      print(' sunrise time: $sunriseTime');
    } else {
      print('Sunrise time not available');
    }
  }
  //String reminderTime = int.parse(sunset-time).toString();
  @override
  Widget build(BuildContext context) {
    print(DateFormat.jm().format(DateTime.now()));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Center(
             child: ElevatedButton(onPressed: () {
               date();
             }, child: Text('data')),
           )
        ],
      ),
    );
  }
}
