import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_countdown/count_down_list/countdown_list_view.dart';

import 'countdown_list_element.dart';

class CountDownListViewPage extends Page {
  CountDownListViewPage([this.onElementTap]) : super();

  final CountdownElementTap? onElementTap;
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return CountDownListView(onElementTap);
        });
  }
}
