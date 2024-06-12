import 'package:flutter/material.dart';
import 'dart:async';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:audioplayers/audioplayers.dart';

void main() {
  tz.initializeTimeZones();
  runApp(ClockApp());
}

class ClockApp extends StatefulWidget {
  @override
  _ClockAppState createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  String _time = '';
  TimeOfDay? _alarmTime;
  late AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    _audioCache = AudioCache();
    _updateTime();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    final nepalTimeZone = tz.getLocation('Asia/Kathmandu');
    final now = tz.TZDateTime.now(nepalTimeZone);
    setState(() {
      _time =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    });

    if (_alarmTime != null &&
        now.hour == _alarmTime!.hour &&
        now.minute == _alarmTime!.minute &&
        now.second == 0) {
      _playAlarmSound();
    }
  }

  void _playAlarmSound() {
    _audioCache.play('alarm_sound.mp3');
  }

  Future<void> _setAlarm(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _alarmTime = pickedTime;
      });
      print('Alarm is set for ${pickedTime.hour}:${pickedTime.minute}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Clock'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                _time,
                style: TextStyle(fontSize: 48),
              ),
            ),
            SizedBox(height: 20),
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => _setAlarm(context),
                child: Text('Set Alarm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
