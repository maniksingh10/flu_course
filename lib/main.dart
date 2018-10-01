import 'package:flutter/material.dart';
import './UI/dHome.dart';
import 'package:flutter/services.dart';

void main() {
  
  runApp(MyApp());

}

class MyApp extends StatelessWidget{
  
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      SystemChrome.setEnabledSystemUIOverlays([]);
      return MaterialApp(
        title: "fLogin",
        home: Home(),
      );
    }
}