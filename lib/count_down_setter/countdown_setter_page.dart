import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'countdown_setter.dart';

class CountdownSetterPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return CountDownSetter();
        });
  }
}
