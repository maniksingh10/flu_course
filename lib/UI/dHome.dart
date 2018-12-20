import 'package:flutter/material.dart';
import '../utils/utils.dart' as utils_data;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  void showStuff() async {
    Map weatherData = await getWeather(utils_data.api_id, utils_data.city);
    print(weatherData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            showStuff();
          },
          color: Colors.white,
        ),
        title: Text("Weather"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/indiagate.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            "New Delhi",
            style: citystyle(),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
          ),
          Container(
            child: UpdateTemp(),
          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String api, String city) async {
    String api_url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api&units=metric";

    http.Response response = await http.get(api_url);

    return json.decode(response.body);
  }

  Widget UpdateTemp() {
    return FutureBuilder(
        future: getWeather(utils_data.api_id, utils_data.city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
      if (snapshot.hasData) {
        Map content = snapshot.data;
        return Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  content['main']['temp'].toString(),
                  style: citystyle(),textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
      }else{
        return Container();
      }
    });
  }
}

TextStyle citystyle() {
  return TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700);
}
