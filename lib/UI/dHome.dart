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
  String _citysearch;

  Future _gotoChangeCity(BuildContext context) async {
    Map resultsfromchangecity = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return ChangeCity();
    }));
    if (resultsfromchangecity != null &&
        resultsfromchangecity.containsKey("enteredcity")) {
      _citysearch = resultsfromchangecity['enteredcity'];
    }
  }

  void showStuff() async {
    Map weatherData =
        await getWeather(utils_data.api_id, utils_data.default_city);
    print(weatherData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _gotoChangeCity(context);
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
              width: 500.0,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            "${_citysearch == null ? utils_data.default_city : _citysearch}",
            style: citystyle(),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
          ),
          Container(
            child: UpdateTemp(_citysearch),
          ),
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

  Widget UpdateTemp(String city) {
    return FutureBuilder(
        future: getWeather(
            utils_data.api_id, city == null ? utils_data.default_city : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            int res_code = content['cod'];
            if (res_code == 200) {
              String condtion_wether;
              var videos = content['weather'] as List; //returns a List of Maps
              for (var items in videos) {
                //iterate over the list
                Map myMap = items; //store each map
                condtion_wether = myMap['main'];
              }
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Min↓\n${content['main']['temp_min'].toString()}°C",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "${(content['main']['temp']).toString()}°",
                            style: citystyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Max↑\n${content['main']['temp_max'].toString()}°C",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  Center(
                    child: Text(
                      "Weather condition = $condtion_wether",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              );
            }
          } else {
            return Container();
          }
        });
  }
}

class ChangeCity extends StatelessWidget {
  var _CityFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChangeCityBar"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Center(
              child: Image.asset('images/delhi.jpg'),
            ),
            ListTile(
              title: TextField(
                controller: _CityFieldController,
                decoration: InputDecoration(
                  labelText: "Enter City Name",
                ),
              ),
            ),
            ListTile(
              title: FlatButton(
                onPressed: () {
                  Navigator.pop(context,
                      {'enteredcity': _CityFieldController.text.toString()});
                },
                child: Text("Get Weather"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

TextStyle citystyle() {
  return TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700);
}
