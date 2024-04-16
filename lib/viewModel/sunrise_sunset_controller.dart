import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app/model/sunrise_sunset_model.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_api.dart';
import 'package:weather/weather.dart';

class SunriseSunsetController extends GetxController {
  WeatherFactory? ws;
  Rx<Weather?> weather = Rx<Weather?>(null);
  String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
  RxString sunrise = ''.obs;
  RxString sunset = ''.obs;
  RxBool isLoad = false.obs;
  SunriseSunsetModel? sunriseSunsetModel;
  RxString selectedValue = ''.obs;


  @override
  void onInit() async {
    super.onInit();
    //ws = new WeatherFactory('da10025ef9d55e2bbbf4665cdbfaad73', language: Language.ENGLISH);
    sunrise.value = PrefServices.getString('sunrise');
    sunset.value = PrefServices.getString('sunset');
    //fetchWeather;
    getSunriseSunsetTime;
  }
  // Future<void> fetchWeather(double latitude, double longitude) async {
  //   try {
  //     isLoad.value = true;
  //     Weather? newWeather = await ws!.currentWeatherByLocation(latitude, longitude);
  //     if (newWeather != null) {
  //       weather.value = newWeather; // Update weather data
  //       sunrise.value = DateFormat('hh:mm:ss a').format(newWeather.sunrise?.toLocal() ?? DateTime.now());
  //       sunset.value = DateFormat('hh:mm:ss a').format(newWeather.sunset?.toLocal() ?? DateTime.now());
  //       PrefServices.setValue('sunrise', sunrise.value);
  //       PrefServices.setValue('sunset', sunset.value);
  //     }
  //     isLoad.value = false;
  //   } catch (e) {
  //     print('Error fetching weather: $e');
  //     isLoad.value = false;
  //   }
  // }

  Future<void> getSunriseSunsetTime(double latitude,double longitude) async {
    isLoad.value = true;
    sunriseSunsetModel = await SunriseSunsetApi.getData(latitude, longitude);
    sunrise.value =sunriseSunsetModel?.results.sunrise ?? '';
    sunset.value =sunriseSunsetModel?.results.sunset ?? '';
    PrefServices.setValue('sunrise', sunrise.value);
    PrefServices.setValue('sunset', sunset.value);
    isLoad.value = false;
    update();
  }
  // Future<void> getSunriseSunsetTime(double latitude, double longitude) async {
  //   isLoad.value = true;
  //   try {
  //     sunriseSunsetModel = await SunriseSunsetApi.getData(latitude, longitude);
  //
  //     // Parse sunrise time string into DateTime object
  //     DateTime sunriseTime = parseTimeOfDay(sunriseSunsetModel!.results.sunrise);
  //
  //     // Subtract one minute from sunrise time
  //     sunriseTime = sunriseTime.subtract(Duration(minutes: 1));
  //
  //     // Format adjusted sunrise time back into string
  //     sunriseSunsetModel!.results.sunrise = formatTimeOfDay(sunriseTime);
  //
  //     // Display the sunrise and sunset times
  //     sunrise.value = sunriseSunsetModel!.results.sunrise;
  //     sunset.value = sunriseSunsetModel!.results.sunset;
  //
  //     // Save values to SharedPreferences or wherever needed
  //     PrefServices.setValue('sunrise', sunrise.value);
  //     PrefServices.setValue('sunset', sunset.value);
  //
  //     // Update UI
  //     isLoad.value = false;
  //     update();
  //   } catch (e, stackTrace) {
  //     print('Error fetching sunrise sunset data: $e');
  //     print('Stack trace: $stackTrace');
  //     // Handle the error (e.g., display an error message to the user)
  //     isLoad.value = false;
  //   }
  // }
  //
  //
  // DateTime parseTimeOfDay(String timeString) {
  //   // Assuming the time string follows the format "hh:mm:ss a"
  //   List<String> parts = timeString.split(' ');
  //   List<String> timeParts = parts[0].split(':');
  //   int hours = int.parse(timeParts[0]);
  //   int minutes = int.parse(timeParts[1]);
  //   int seconds = int.parse(timeParts[2]);
  //   if (parts[1] == 'PM' && hours != 12) {
  //     hours += 12;
  //   }
  //   return DateTime(0, 0, 0, hours, minutes, seconds);
  // }
  //
  // String formatTimeOfDay(DateTime time) {
  //   String hour = time.hour.toString().padLeft(2, '0');
  //   String minute = time.minute.toString().padLeft(2, '0');
  //   String second = time.second.toString().padLeft(2, '0');
  //   String period = time.hour < 12 ? 'AM' : 'PM';
  //   return '$hour:$minute:$second $period';
  // }

  Future<void> clearSunriseSunsetData() async {
    sunrise.value = '';
    sunset.value = '';
    await PrefServices.removeValue('sunrise');
    await PrefServices.removeValue('sunset');
  }
}