import 'package:flutter/material.dart';
import './UI/dHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: "fLogin",
        home: Home(),
      );
    }
}