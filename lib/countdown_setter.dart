import 'dart:html';
import 'dart:developer' as developer;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CountdownStore.dart';
import 'count_down.dart';

class CountDownSetter extends StatefulWidget {
  @override
  _CountdownSetterState createState() => _CountdownSetterState();
}

class _CountdownSetterState extends State<CountDownSetter> {
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  TextEditingController textController = TextEditingController();

  final Color color = const Color(0x000000);

  _CountdownSetterState createState() => _CountdownSetterState();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    final eventNameRow = Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text("Event Name"),
          ),
          Expanded(
            child: TextField(
                controller: textController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Event Name')),
          )
        ],
      ),
    );

    final dateRow = Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
              child: ElevatedButton(
            style: style,
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.utc(9999, 12, 31))
                  .then((value) => {
                        if (value != null)
                          {
                            setState(() {
                              selectedDate = value;
                            })
                          }
                      });
            },
            child: const Text('Select Date'),
          )),
          Expanded(
            child: Text(
                '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}'),
          )
        ],
      ),
    );

    final timeRow = Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              style: style,
              onPressed: () {
                showTimePicker(context: context, initialTime: selectedTime)
                    .then((value) {
                  if (value != null)
                    setState(() {
                      selectedTime = value;
                    });
                });
              },
              child: const Text('Select Time'),
            ),
          ),
          Expanded(
            child: Text('${selectedTime.hour} h, ${selectedTime.minute}'),
          )
        ],
      ),
    );

    final buttonRow = Container(
      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
                style: style,
                onPressed: () {
                  bool nameExists =
                      Provider.of<CountdownStore>(context, listen: false)
                          .containsEventName(textController.text);
                  if (!nameExists) {
                    DateTime countDownDateTime = new DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute);

                    CountDown newCountdown =
                        new CountDown(textController.text, countDownDateTime);
                    Provider.of<CountdownStore>(context, listen: false)
                        .addCountDown(newCountdown);
                    developer.log(
                        "Added Countdown of Name: ${newCountdown.eventName}, with Countdown: T:${newCountdown.targetDateTime.hour}:${newCountdown.targetDateTime.minute} D:${newCountdown.targetDateTime.day}.${newCountdown.targetDateTime.month}${newCountdown.targetDateTime.year} ");
                  } else {
                    developer.log("Countdown already Exist!");
                  }
                },
                child: const Text('Timer erstellen')),
          )
        ],
      ),
    );
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Container(
            color: color,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              eventNameRow,
              dateRow,
              timeRow,
              buttonRow
            ])));
  }
}
