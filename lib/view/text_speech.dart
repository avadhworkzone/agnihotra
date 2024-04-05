// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// class TextToSpeechScreen extends StatefulWidget {
//   const TextToSpeechScreen({Key? key}) : super(key: key);
//
//   @overridea
//   State<TextToSpeechScreen> createState() => _TextToSpeechScreenState();
// }
//
// class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
//   final FlutterTts flutterTts = FlutterTts();
//   @override
//   void initState() {
//     super.initState();
//     flutterTts.setLanguage('en-US');
//     flutterTts.setSpeechRate(0.1);
//     flutterTts.setVolume(1.0);
//     flutterTts.setPitch(1.0);
//   }
//
//   Future<void> speakText() async {
//     String allText = '';
//     // Concatenate all text
//     allText = 'Hello, this is a test. Flutter Text to Speech Demo.';
//
//     await flutterTts.speak(allText);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Text to Speech Demo'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             flutterTts.speak('Hello, Flutter Text-to-Speech!');
//           },
//           child: Text('Speak'),
//         ),
//       ),
//     );
//   }
// }
