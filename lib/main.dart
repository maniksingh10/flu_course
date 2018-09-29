import 'package:flutter/material.dart';
import 'UI/dHome.dart';
void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "fSca",
      home: Home(),
    );
  }
}


