import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:weather/weather.dart';


class SunriseSunsetController extends GetxController {
  WeatherFactory? ws;
  Rx<Weather?> weather = Rx<Weather?>(null);
  String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
  RxString sunrise = ''.obs;
  RxString sunset = ''.obs;
  RxBool isLoad = false.obs;

  @override
  void onInit() async {
    super.onInit();
   // await PrefServices.init(); // Initialize preferences
    ws = new WeatherFactory('da10025ef9d55e2bbbf4665cdbfaad73', language: Language.ENGLISH);
    sunrise.value = PrefServices.getString('sunrise');
    sunset.value = PrefServices.getString('sunset');
    fetchWeather;
  }
  Future<void> fetchWeather(double latitude, double longitude) async {
    try {
      isLoad.value = true;
      Weather? newWeather = await ws!.currentWeatherByLocation(latitude, longitude);
      if (newWeather != null) {
        weather.value = newWeather; // Update weather data
        sunrise.value = DateFormat('hh:mm:ss a').format(newWeather.sunrise?.toLocal() ?? DateTime.now());
        sunset.value = DateFormat('hh:mm:ss a').format(newWeather.sunset?.toLocal() ?? DateTime.now());
        PrefServices.setValue('sunrise', sunrise.value);
        PrefServices.setValue('sunset', sunset.value);
      }
      isLoad.value = false;
    } catch (e) {
      print('Error fetching weather: $e');
      isLoad.value = false;
    }
  }


  Future<void> clearLocationData() async {
    sunrise.value = '';
    sunset.value = '';
    await PrefServices.removeValue('sunrise');
    await PrefServices.removeValue('sunset');
  }
}


