import 'package:flutter/material.dart';
import './dBody.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Planet")),
      
       body: Body(),
       
    );
  }
}
