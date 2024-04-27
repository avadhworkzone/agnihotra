import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

import 'package:sunrise_app/services/prefServices.dart';


class MeditationScreen extends StatefulWidget {
  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  late AudioPlayer _audioPlayer;
  late Timer _timer;
  bool _isBellRinging = false; // Track whether the bell is currently ringing

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _isBellRinging = PrefServices.getBool('isBellRinging') ?? false;
    if (_isBellRinging) {
      _startTimer(); // Start the timer if the bell is already ringing
    }
  }
  void _startTimer() {
    // Schedule the bell to ring at 12:42:00 PM
    DateTime now = DateTime.now();
    DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      14, // 12 PM
      23, // 42 minutes
      0, // 0 seconds
    );

    // Check if the scheduled time is already passed for today
    if (now.isAfter(scheduledTime)) {
      // If passed, schedule the bell for the next day
      scheduledTime = scheduledTime.add(Duration(days: 1));
    }

    // Calculate the duration until the scheduled time
    Duration durationUntilScheduledTime = scheduledTime.difference(now);

    // Schedule the timer to ring the bell
    _timer = Timer(durationUntilScheduledTime, () {
      if (_isBellRinging) {
        _ringBell(); // Only ring the bell if it's currently enabled
      }
      // Reschedule the timer for the next day
      _startTimer();
    });
  }

  Future<void> _ringBell() async {
    await _audioPlayer.setAsset('assets/audio/meditation_bell.mp3');
    await _audioPlayer.play();
    // You can add any additional actions here when the bell rings
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation Bell'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bell will ring at 14:23:00 PM',
              style: TextStyle(fontSize: 20),
            ),
            Switch(
              value: _isBellRinging,
              onChanged: (value) {
                setState(() {
                  _isBellRinging = value;
                  PrefServices.setValue('isBellRinging', _isBellRinging);
                  if (_isBellRinging) {
                    _startTimer(); // Start the timer when the switch is turned on
                  } else {
                    _timer.cancel(); // Cancel the timer when the switch is turned off
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _timer.cancel();
    super.dispose();
  }
}




