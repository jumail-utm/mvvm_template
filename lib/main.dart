import 'package:flutter/material.dart';

import 'app/dependencies.dart' as di;
import 'app/router.dart';

void main() {
  di.init();

  runApp(
    MaterialApp(
      title: 'MVVM Template',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: createRoute,
    ),
  );
}
