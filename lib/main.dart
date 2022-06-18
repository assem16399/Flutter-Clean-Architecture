import 'package:flutter/material.dart';

import 'core/styles/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Clean Architecture',
      theme: ThemeManager.appTheme,
      home: const Scaffold(
        body: Center(
          child: Text("Flutter Clean Architecture"),
        ),
      ),
    );
  }
}
