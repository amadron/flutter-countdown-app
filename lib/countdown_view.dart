import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

import 'package:simple_countdown/countdown_view_element.dart';

class CountDownView extends StatefulWidget {
  CountDownView({Key? key, required this.eventName, required this.date})
      : super(key: key);

  final DateTime date;
  final String eventName;

  @override
  _CountDownViewState createState() =>
      _CountDownViewState(this.eventName, this.date);
}

class _CountDownViewState extends State<CountDownView> {
  DateTime date;
  String countDownText = "";
  String eventName;
  int durationHours = 0;
  int durationMinutes = 0;
  int durationSeconds = 0;
  int durationDays = 0;
  Timer? updateTimer;
  bool isOver = false;

  _CountDownViewState(this.eventName, this.date);

  void updateCountDownText() {
    DateTime now = DateTime.now();
    isOver = date.isBefore(now);
    var difference = date.difference(now);
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;
    /*developer.log(
        'D:${difference.inDays}, H:${difference.inHours}, M:${difference.inMinutes}, S:${difference.inSeconds}'); */
    String countDownString =
        '${difference.inDays} D, ${hours} h, ${minutes} m, ${seconds} s';
    if (!mounted) return;
    setState(() {
      durationHours = hours;
      durationMinutes = minutes;
      durationSeconds = seconds;
      durationDays = difference.inDays;
      countDownText = countDownString;
    });
  }

  @override
  void dispose() {
    updateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const intervall = const Duration(milliseconds: 200);

    updateTimer = new Timer.periodic(intervall, (timer) {
      developer.log("Execute Timer");
      updateCountDownText();
    });

    updateCountDownText();
    if (!isOver) {
      return CountDownViewElement(eventName, durationDays, durationHours,
          durationMinutes, durationSeconds);
    } else {
      updateTimer?.cancel();
      return Text("Countdown is over",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold));
    }
  }
}
