import 'package:flutter/material.dart';
import 'package:simple_countdown/count_down_view/countdown_view.dart';

class CountDownViewPage extends Page {
  final String eventName;
  final DateTime date;

  CountDownViewPage({required this.eventName, required this.date});

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return CountDownView(eventName: eventName, date: date);
        });
  }
}
