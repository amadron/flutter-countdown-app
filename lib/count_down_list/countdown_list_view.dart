import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_countdown/count_down_list/countdown_list_element.dart';

import '../count_down_store/CountdownStore.dart';
import '../count_down_store/count_down.dart';
import '../count_down_setter/countdown_setter.dart';

class CountDownListView extends StatelessWidget {
  CountDownListView([this.onElementTap]) : super();

  final CountdownElementTap? onElementTap;
  @override
  Widget build(BuildContext context) {
    const noDataStyle = TextStyle(fontSize: 26, fontWeight: FontWeight.bold);

    return Scaffold(
        appBar: AppBar(title: const Text("ContDown List")),
        body: Consumer<CountdownStore>(builder: (context, store, child) {
          UnmodifiableListView<CountDown> storeList = store.getCountDowns;
          if (storeList.length != 0) {
            List<Widget> countDownList = [];
            storeList.forEach((element) {
              countDownList.add(
                Padding(
                    padding: EdgeInsets.all(2),
                    child: CountDownListElement(element.eventName,
                        element.targetDateTime, onElementTap)),
              );
              countDownList.add(SizedBox(
                width: 100,
              ));
            });
            return Container(
              margin: const EdgeInsets.only(left: 50, right: 50),
              alignment: Alignment.center,
              child: Column(
                children: countDownList,
              ),
            );
          } else {
            return Container(
                alignment: Alignment.center,
                child: Text(
                  "No Countdowns available",
                  style: noDataStyle,
                ));
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                        body: Center(
                      child: CountDownSetter(),
                    ))),
          ),
          tooltip: 'Add Countdown',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
