import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';




class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final TextEditingController _controller = TextEditingController();
  int _minutesBefore = 5;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Alarm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter minutes before'),
              onChanged: (value) {
                setState(() {
                  _minutesBefore = int.tryParse(value) ?? 5;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                _setAlarm(_minutesBefore);
              },
              child: Text('Set Alarm'),
            ),
          ],
        ),
      ),
    );
  }

  void _setAlarm(int minutesBefore) {
    final now = DateTime.now();
    final alarmTime = DateTime(now.year, now.month, now.day, 5, 40, 00); // Set your desired alarm time here
    final alarmTimeBefore = alarmTime.subtract(Duration(minutes: minutesBefore));

    // Schedule the alarm 'minutesBefore' minutes before the specified time
    AndroidAlarmManager.oneShotAt(alarmTimeBefore, 0, _onAlarm);
  }

  void _onAlarm() {
    // Code to execute when the alarm triggers
    print('Alarm triggered!');
  }
}
