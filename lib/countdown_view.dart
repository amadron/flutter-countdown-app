import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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

  _CountDownViewState(this.eventName, this.date);

  void updateCountDownText() {
    var difference = date.difference(DateTime.now());
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;
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
      updateCountDownText();
    });

    const countDownStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 40);
    const headLineStyle =
        TextStyle(fontWeight: FontWeight.normal, fontSize: 30);
    updateCountDownText();
    const double middleSpace = 20;
    return Container(
        color: Colors.lightBlue.shade50,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Name", style: headLineStyle),
                  Text(this.eventName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30)),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Spacer(),
                  Column(
                    children: [
                      Text("D", style: headLineStyle),
                      Text("$durationDays", style: countDownStyle)
                    ],
                  ),
                  SizedBox(width: middleSpace),
                  Column(
                    children: [
                      Text("H", style: headLineStyle),
                      Text(
                        "$durationHours",
                        style: countDownStyle,
                      ),
                    ],
                  ),
                  SizedBox(width: middleSpace),
                  Column(
                    children: [
                      Text("M", style: headLineStyle),
                      Text(
                        "$durationMinutes",
                        style: countDownStyle,
                      ),
                    ],
                  ),
                  SizedBox(width: middleSpace),
                  Column(
                    children: [
                      Text("S", style: headLineStyle),
                      Text(
                        "$durationSeconds",
                        style: countDownStyle,
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ]));
  }
}
