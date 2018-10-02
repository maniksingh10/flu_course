import 'package:flutter/material.dart';
import './dBody.dart';
class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI")),
      body: MyBody(),
    );
  }
}
