import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as htttp;

void main() async {
  List _data = await getJSON();
  print(_data);

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("JSon"),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
        itemCount: _data.length,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int postito) {
          return Column(
            children: <Widget>[
              Divider(
                height: 8.0,
              ),
              ListTile(
                title: Text(
                  "${_data[postito]['title']}",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  "${_data[postito]["body"]}",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 25.0,
                  child: Text("${_data[postito]["body"][0]}".toUpperCase(),
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                onTap: () {_showDialog(context, "${_data[postito]["body"]}");},
              )
            ],
          );
        },
      )),
    ),
  ));
}

void _showDialog(BuildContext context, String message) {
  var alertd = AlertDialog(
    title: Text("Alert Dialog"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(child: Text("Done"), onPressed: () {
        Navigator.pop(context);
      },

      )
    ],
  );
  showDialog(context: context, builder: (context)=>alertd);
}

Future<List> getJSON() async {
  String url = "https://jsonplaceholder.typicode.com/posts";
  htttp.Response response = await htttp.get(url);

  return json.decode(response.body);
}
