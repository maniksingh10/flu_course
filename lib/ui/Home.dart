import 'package:flu_course/ui/Notodo.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not To Do"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body:NoToDoScreen(),
    );
  }
}