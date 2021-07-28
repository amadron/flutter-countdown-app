import 'dart:collection';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_countdown/countdown_list_element.dart';

import 'CountdownStore.dart';
import 'count_down.dart';
import 'countdown_setter.dart';

class CountDownListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    child: CountDownListElement(
                        element.eventName, element.targetDateTime)),
              );
              countDownList.add(SizedBox(
                width: 100,
              ));
            });
            return FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  child: Column(
                    children: countDownList,
                  ),
                ));
          } else {
            return Text("No CountDowns Yet");
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
