import 'package:provider/provider.dart';

import 'myapp.dart';
import 'CountdownStore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => new CountdownStore(),
      child: MyApp(),
    ),
  );
}
