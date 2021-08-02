import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:simple_countdown/count_down_view/countdown_view_page.dart';
import 'dart:developer' as developer;

import 'count_down_list/countdown_list_view_page.dart';
import 'count_down_store/count_down.dart';

class MyCountdownApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCountdownAppState();
}

class MyCountdownAppState extends State<MyCountdownApp> {
  CountDown? selectedCountdown;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var onCountdownListViewTap = (CountDown countDown) {
      setState(() {
        selectedCountdown = countDown;
      });
      developer.log("Countdown selected!");
    };
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigator(
        pages: [
          if (selectedCountdown != null)
            CountDownViewPage(
                eventName: selectedCountdown!.eventName,
                date: selectedCountdown!.targetDateTime),
          if (selectedCountdown == null)
            CountDownListViewPage(onCountdownListViewTap)
        ],
        onPopPage: (route, result) {
          developer.log("Backbutton Pressed!");
          if (!route.didPop(result)) {
            return false;
          }
          setState(() {
            selectedCountdown = null;
          });
          return true;
        },
      ),
      // Scaffold(
      //     body: Center(
      //   child: CountDownListView(),
      // )),
    );
  }
}
