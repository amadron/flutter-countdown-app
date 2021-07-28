import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'countdown_view.dart';

class CountDownListElement extends StatelessWidget {
  const CountDownListElement(this.title, this.date);

  final String title;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Scaffold(
                        body: Center(
                            child: CountDownView(
                          eventName: title,
                          date: date,
                        )),
                      )));
        },
        child: Container(
            color: Colors.blueAccent,
            child: Column(
              children: [
                Row(children: [
                  Text("Title"),
                  SizedBox(width: 20),
                  Text(title)
                ]),
                Row(children: [
                  Text("Date"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                      "${date.hour}:${date.minute} ${date.day}.${date.month}.${date.year}")
                ]),
              ],
            )));
  }
}
