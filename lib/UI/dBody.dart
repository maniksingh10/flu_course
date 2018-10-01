import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  final TextEditingController _weightController = new TextEditingController();
  int radiovalue = 0;
  double _finalWeight = 0.0;
  String _formatedText = "";
  void onRadioValueChange(int value) {
    setState(() {
      radiovalue = value;
      switch (radiovalue) {
        case 0:
          _finalWeight = calculateWeight(_weightController.text, 0.38);
          _formatedText =
              "Your Weight on Mars is ${_finalWeight.toStringAsFixed(1)}";
          break;
        case 1:
          _finalWeight = calculateWeight(_weightController.text, 2.34);
          _formatedText =
              "Your Weight on Jupiter is ${_finalWeight.toStringAsFixed(1)}";
          break;
        case 2:
          _finalWeight = calculateWeight(_weightController.text, 1.19);
          _formatedText =
              "Your Weight on Neptune is ${_finalWeight.toStringAsFixed(1)}";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16.0),
            child: Image.asset(
              "images/planet.png",
              width: 150.0,
              height: 150.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 36.0),
            child: TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Your weight on Earth",
                hintText: "In Kilograms",
                icon: Icon(Icons.bala),
                contentPadding: EdgeInsets.symmetric(vertical: 3.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio<int>(
                activeColor: Colors.red.shade600,
                groupValue: radiovalue,
                onChanged: onRadioValueChange,
                value: 0,
              ),
              Text(
                "Mars",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Radio<int>(
                activeColor: Colors.deepOrangeAccent,
                groupValue: radiovalue,
                onChanged: onRadioValueChange,
                value: 1,
              ),
              Text(
                "Jupiter",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Radio<int>(
                activeColor: Colors.deepPurpleAccent,
                groupValue: radiovalue,
                onChanged: onRadioValueChange,
                value: 2,
              ),
              Text(
                "Neptune",
                style: TextStyle(fontWeight: FontWeight.w700),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(_weightController.text.isEmpty ? "Please Enter Your Weight" : _formatedText + "kgs",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.0,
                )),
          ),
        ],
      ),
    );
  }

  double calculateWeight(String text, double d) {
    int _weight = int.parse(text);
    return _weight * d;
  }
}
