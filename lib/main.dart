import 'package:provider/provider.dart';

import 'my_countdown_app.dart';
import 'count_down_store/CountdownStore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => new CountdownStore(),
      child: MyCountdownApp(),
    ),
  );
}
