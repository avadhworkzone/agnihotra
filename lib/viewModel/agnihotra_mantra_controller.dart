import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sunrise_app/utils/image_utils.dart';

class AgnihotraMantraController extends GetxController{

 final sunriseAudio = AudioPlayer();
 final sunsetAudio = AudioPlayer();



 Future<void> sunriseMantraAudio() async {
   try {
     if (sunriseAudio.playing) {
       await sunriseAudio.stop();
     } else {

        sunriseAudio.setAsset(AssetUtils.sunriseMantraAudio);
       await sunriseAudio.play();

       sunriseAudio.setLoopMode(LoopMode.one);
     }
   } catch (e) {
     print('Error playing sunrise mantra audio: $e');
   }
 }
 Future<void> sunsetMantraAudio() async {
   try {
     if (sunsetAudio.playing) {
       await sunsetAudio.stop();
     }
     else{


       sunsetAudio.setAsset(AssetUtils.sunsetMantraAudio);
       await sunsetAudio.play();

       sunsetAudio.setLoopMode(LoopMode.one);
     }
   } catch (e) {
     print('Error playing sunset mantra audio: $e');
   }
 }
 @override
  void dispose() {
    // TODO: implement dispose
   sunriseAudio.dispose();
   sunsetAudio.dispose();
    super.dispose();

  }
}