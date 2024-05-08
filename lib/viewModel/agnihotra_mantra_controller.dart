import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sunrise_app/utils/image_utils.dart';

class AgnihotraMantraController extends GetxController{


 late AudioPlayer sunriseAudio;
 late AudioPlayer sunsetAudio;

 @override
 void onInit() {
   super.onInit();
   // Initialize the audio player
   sunriseAudio = AudioPlayer();
   sunsetAudio = AudioPlayer();
 }
 // Method to play or pause the audio
 Future<void> sunriseMantraAudio() async {

   try {
     if (sunriseAudio.playing){
       // If audio is already playing, pause it
       await sunriseAudio.pause();
     } else {
       // If audio is paused or stopped, play it
       sunriseAudio.setAsset(AssetUtils.sunriseMantraAudio);
       await sunriseAudio.play();
       sunriseAudio.setLoopMode(LoopMode.off);
     }

     // Listen for player state changes
     sunriseAudio.playerStateStream.listen((playerState){
       if (playerState.processingState == ProcessingState.completed){
         // When playback completes, stop the audio and update UI
         sunriseAudio.pause();
         update(); // Update the UI to reflect the change

         print("STOP AUDIO===================");
       }
     });
   } catch (e) {
     print('Error playing sunrise mantra audio: $e');
   }
 }

 Future<void> sunsetMantraAudio() async {
   try {

     if(sunsetAudio.playing){
       await sunsetAudio.stop();
     }

     else{


       sunsetAudio.setAsset(AssetUtils.sunsetMantraAudio);
       await sunsetAudio.play();

       sunsetAudio.setLoopMode(LoopMode.off);
     }

     // Listen for player state changes
     sunsetAudio.playerStateStream.listen((playerState) {
       if (playerState.processingState == ProcessingState.completed){
         // When playback completes, stop the audio and update UI
         sunsetAudio.pause();
         update(); // Update the UI to reflect the change

         print("STOP AUDIO===================");
       }
     });
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