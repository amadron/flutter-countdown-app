import 'package:flutter/material.dart';

class CountDownViewElement extends StatelessWidget {
  CountDownViewElement(this.eventName, this.durationDays, this.durationHours,
      this.durationMinutes, this.durationSeconds);

  final String eventName;
  final int durationDays;
  final int durationHours;
  final int durationMinutes;
  final int durationSeconds;

  @override
  Widget build(BuildContext context) {
    const countDownStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 40);
    const headLineStyle =
        TextStyle(fontWeight: FontWeight.normal, fontSize: 30);
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
