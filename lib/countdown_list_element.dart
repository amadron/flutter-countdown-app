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
    const headLineStyle = TextStyle(fontSize: 22);
    const dataStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 26);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
          color: Colors.blueAccent,
          child: InkWell(
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
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 100,
              child: Row(
                children: [
                  Container(
                    width: 30,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Title",
                                style: headLineStyle,
                              ),
                              SizedBox(width: 20),
                              Text(
                                title,
                                style: dataStyle,
                              )
                            ]),
                        SizedBox(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("${date.day}.${date.month}.${date.year}",
                                  style: dataStyle),
                              SizedBox(
                                width: 30,
                              ),
                              Icon(Icons.schedule,
                                  size: 20, color: Colors.black),
                              SizedBox(
                                width: 10,
                              ),
                              Text("${date.hour}:${date.minute}",
                                  style: dataStyle),
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
