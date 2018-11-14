import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

List _quakesData;

void main() async {
  Map _allData = await getQuakesData();
   _quakesData = _allData["features"];

  runApp(MaterialApp(
    title: "Quakes",
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("EarthQuakes"),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int position) {
          var format = DateFormat.yMMMMd("en_US").add_jm();
          var date = format.format(new DateTime.fromMillisecondsSinceEpoch(
              _quakesData[position]["properties"]["time"],
              isUtc: true));
        

          return Column(
            children: <Widget>[
              Divider(
                height: 15.0,
              ),
              ListTile(
                title: Text(
                  "$date",
                  style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  "${_quakesData[position]["properties"]["place"]}",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  maxRadius: 25.0,
                  backgroundColor: _circleColor(_quakesData[position]["properties"]["mag"].toString()),
                  child: Text(
                    "${_quakesData[position]["properties"]["mag"]}",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                onTap: () {
                  _showDialog(
                      context, "${_quakesData[position]["properties"]["url"]}");
                },
              )
            ],
          );
        },
        itemCount: _quakesData.length,
      ),
    );
  }
}

void _showDialog(BuildContext context, String s) {
  var cupertinoAlert = CupertinoAlertDialog(
    title: const Text('Open Url?'),
    content: Text(s),
    actions: <Widget>[
      CupertinoDialogAction(
        child: const Text('Discard'),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context, 'Discard');
        },
      ),
      CupertinoDialogAction(
        child: const Text('Open'),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Open');
          _launchURL(s);
        },
      ),
    ],
  );
  showDialog(context: context, builder: (context) => cupertinoAlert);
}

_launchURL(String a) async {
  String url = a;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  
Color _circleColor(String mag) {
  double magint = double.parse(mag);
  if(magint>7.0){
    return Colors.red.shade700;
  }else if(magint>4.0 && magint<7.0){
    return Colors.yellow.shade600;
  }else{
    return Colors.greenAccent;
  }
}

Future<Map> getQuakesData() async {
  String url =
      "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&orderby=time&minmag=1&limit=300&maxlatitude=33.211&minlatitude=16.13&maxlongitude=87.012&minlongitude=70.4";
  http.Response responsee = await http.get(url);
  return json.decode(responsee.body);
}


