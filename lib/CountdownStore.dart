import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'count_down.dart';
import 'dart:developer' as developer;
import 'app_util.dart';

class CountdownStore extends ChangeNotifier {
  CountdownStore() {
    initStorage();
  }

  var path;
  final List<CountDown> _countDowns = [];

  int get amountOfCountDowns => _countDowns.length;

  UnmodifiableListView<CountDown> get getCountDowns =>
      UnmodifiableListView(_countDowns);

  void initStorage() async {
    final prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    keys.forEach((key) {
      String? dateString = prefs.getString(key);
      if (dateString != null) {
        DateTime targetDate = DateTime.parse(dateString);
        CountDown tmpCountdown = new CountDown(key, targetDate);
        _countDowns.add(tmpCountdown);
      } else {
        developer.log("No Date Found!");
      }
    });
  }

  void addPersistentEntry(CountDown countdown) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        countdown.eventName, countdown.targetDateTime.toIso8601String());
  }

  void removePersistentEntry(String countdownName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(countdownName);
  }

  void addCountDown(CountDown entry) {
    _countDowns.add(entry);
    addPersistentEntry(entry);
    notifyListeners();
  }

  void removeCountDown(String countDownEventName) {
    _countDowns.forEach((element) {
      if (element.eventName == countDownEventName) _countDowns.remove(element);
      removePersistentEntry(countDownEventName);
      notifyListeners();
      return;
    });
  }

  bool containsEventName(String countDownEventName) {
    bool result = false;
    _countDowns.forEach((element) {
      if (element.eventName == countDownEventName) {
        result = true;
        return;
      }
    });
    return result;
  }
}
