import 'package:flutter/material.dart';
import './dBody.dart';
class Home extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        
        appBar: AppBar(
        title: Text("Login Form"),
        centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor:Colors.greenAccent.shade400,
          child: Icon(Icons.add),
          
          foregroundColor: Colors.white,
        ),
        body: MyAppBody(),
        
      );
    }
}