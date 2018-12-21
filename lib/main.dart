import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(MaterialApp(
    title: "Peristence_Data",
    home: Peristence_App(),
  ));
}

class Peristence_App extends StatefulWidget {
  @override
  _Peristence_AppState createState() => _Peristence_AppState();
}

class _Peristence_AppState extends State<Peristence_App> {
  var _entereddata = TextEditingController();

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
                writeData(_entereddata.text.toString());
              },
              child: Text("Save"),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
            ),
            FutureBuilder(
              future: readData(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot != null && snapshot.hasData) {
                  return Container(
                      child: Text("${snapshot.data.toString()}",
                          textAlign: TextAlign.center));
                } else {
                  return Container(width: 0.0, height: 0.0);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/manik.txt');
}

Future<File> writeData(String msg) async {
  final file = await _localFile;
  return file.writeAsString("$msg");
}

Future<String> readData() async {
  try {
    final file = await _localFile;
    String msg = await file.readAsString();
    return msg;
  } catch (e) {
    return "No Data";
  }
}
