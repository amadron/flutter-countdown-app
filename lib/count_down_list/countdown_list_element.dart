import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_countdown/count_down_store/count_down.dart';
import 'dart:developer' as developer;

import '../count_down_store/CountdownStore.dart';

typedef void CountdownElementTap(CountDown countdown);

class CountDownListElement extends StatelessWidget {
  const CountDownListElement(this.title, this.date, [this.onElementTap]);

  final String title;
  final DateTime date;
  final CountdownElementTap? onElementTap;

  void onTap(BuildContext context) {
    onElementTap!(CountDown(title, date));
  }

  void onLongPress(BuildContext context) {
    developer.log("Lon Press");
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Delete Event"),
        content: Text("Are you sure you want to delete the Event \"$title\""),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Yes');
              Provider.of<CountdownStore>(context, listen: false)
                  .removeCountDown(title);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'No');
            },
            child: const Text('No'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const headLineStyle = TextStyle(fontSize: 22);
    const dataStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 26);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
          color: Colors.blueAccent,
          child: InkWell(
            onTap: () => onTap(context),
            onLongPress: () => onLongPress(context),
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
