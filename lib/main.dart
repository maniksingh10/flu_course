import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(MaterialApp(
    title: "Shared_Pref",
    home: Peristence_App(),
  ));
}

class Peristence_App extends StatefulWidget {
  @override
  _Peristence_AppState createState() => _Peristence_AppState();
}

class _Peristence_AppState extends State<Peristence_App> {
  var _entereddata = TextEditingController();
  String _savedData = "";

  @override
  void initState() {
    super.initState();
    _loadSPdata();
  }

  _loadSPdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if (preferences.getString("data_key") != null&&preferences.getString("data_key").isNotEmpty) {
        _savedData = preferences.getString("data_key");
      }else{
        _savedData = "";
      }
    });
  }

  _saveData(String msg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("data_key", msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SaveData"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: TextField(
                controller: _entereddata,
                decoration: InputDecoration(labelText: "Write Data to Save"),
              ),
            ),
            FlatButton(
              onPressed: () {
                _saveData(_entereddata.text.toString());
              },
              child: Text("Save"),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Text("$_savedData",textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
