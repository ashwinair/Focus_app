import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';

FlutterTts flutterTts = FlutterTts(); //text to speech

Future say(String home, String alert) async {
  await flutterTts.setLanguage("hi-IN");
  await flutterTts.setPitch(1);
  await flutterTts.setVolume(100);
  await flutterTts.speak(" " + home + alert);
  await Vibration.vibrate(duration: 1500); // home alert
}
