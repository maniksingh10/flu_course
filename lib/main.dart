import 'package:flutter/material.dart';
import 'UI/dHome.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
       title: "BMI",
       home: MyHome(),
       theme: ThemeData(primarySwatch: Colors.indigo)
       ,
    );
  }
  

}