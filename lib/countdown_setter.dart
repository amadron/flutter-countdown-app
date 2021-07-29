import 'dart:html';
import 'dart:developer' as developer;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CountdownStore.dart';
import 'count_down.dart';
import 'rounded_button.dart';

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

  void displayDialog(String title, String message, [Function? onAccept]) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              onAccept!();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const dataStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

    const double spcBetweenButtonData = 20;
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    final eventNameRow = Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text("Event Name", style: dataStyle),
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
          RoundedButton("Date", Icons.event, () {
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
          }),
          SizedBox(
            width: spcBetweenButtonData,
          ),
          Expanded(
            child: Text(
              '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
              style: dataStyle,
            ),
          ),
          RoundedButton("Time", Icons.schedule, () {
            showTimePicker(context: context, initialTime: selectedTime)
                .then((value) {
              if (value != null)
                setState(() {
                  selectedTime = value;
                });
            });
          }),
          SizedBox(
            width: spcBetweenButtonData,
          ),
          Expanded(
            child: Text(
              '${selectedTime.hour} h, ${selectedTime.minute}',
              style: dataStyle,
            ),
          )
        ],
      ),
    );

    final timeRow = Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[],
      ),
    );

    final buttonRow = Container(
      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(
                style: style,
                onPressed: () {
                  bool nameExists =
                      Provider.of<CountdownStore>(context, listen: false)
                          .containsEventName(textController.text);
                  bool nameValid = textController.text.isNotEmpty;
                  if (!nameExists && nameValid) {
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
                    displayDialog("Success", "Countdown was created",
                        () => Navigator.pop(context));
                  } else {
                    if (nameExists) {
                      developer.log("Countdown with name already Exist!");
                      displayDialog("Error", "Countdown already Exists!");
                    }
                    if (!nameValid) {
                      developer.log("Please enter a valid countdown name");
                      displayDialog(
                          "Error", "Please enter a valid Countdown Name");
                    }
                  }
                },
                child: const Text('Create Timer')),
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
