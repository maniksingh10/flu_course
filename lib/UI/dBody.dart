import 'package:flutter/material.dart';

class MyBody extends StatefulWidget {
  createState() => MyBody_State();
}

class MyBody_State extends State<MyBody> {
  TextEditingController _age = new TextEditingController();
  TextEditingController _height = new TextEditingController();
  TextEditingController _weight = new TextEditingController();
  Image _male = Image.asset("images/bravo.png");
  Image _female = Image.asset("images/female.png");
  Image _img = Image.asset("images/bravo.png");
  int _radioValue = 0;
  String _result = "";
  Color _color;
  void clearInput() {
    _age.clear();
    _height.clear();
    _weight.clear();
  }

  void onGenderChange(int value) {
    setState(() {
      _radioValue = value;
      _img = _radioValue == 0 ? _male : _female;
    });
  }

 

  void calculate() {
    double weight = double.parse(_weight.text);
    double height =double.parse(_height.text)  ;
    double bmi = weight / (height * height);
    String _condition;

    if(bmi<18.5){
      _condition = "Underweight. Eat Like a King";
      _color = Colors.blue;
    }else if(bmi>=18.5 && bmi<=24.9){
      _condition = "Normal. Keep It Up";
      _color = Colors.greenAccent.shade400;
    }else if(bmi>=25.0 && 29.9>=bmi){
      _condition = "Overweight. Control";
      _color = Colors.yellow.shade800;
    }else if(bmi>= 30.0){
      _condition = "Obese. Eat Healthly";
      _color = Colors.red.shade700;
    }

    setState(() {
      _result = "Your BMI is ${bmi.toStringAsFixed(1)} \n You are $_condition";
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 8.0),
          width: 150.0,
          height: 200.0,
          child: _img,
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          alignment: Alignment.center,
          child: Row(children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                maxLength: 2,
                controller: _age,
                decoration: InputDecoration(
                  labelText: "Enter Age",
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                  icon: Icon(Icons.person),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(12.0)),
            Expanded(
                child: Row(children: <Widget>[
              Radio<int>(
                groupValue: _radioValue,
                onChanged: onGenderChange,
                value: 0,
                activeColor: Colors.black,
              ),
              Text(
                "Male",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Radio<int>(
                groupValue: _radioValue,
                onChanged: onGenderChange,
                value: 1,
                activeColor: Colors.pink,
              ),
              Text(
                "Female",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ]))
          ]),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    controller: _height,
                    maxLength: 3,
                    decoration: InputDecoration(
                      labelText: "Height in mts",
                      contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                      icon: Icon(Icons.graphic_eq),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextField(
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    controller: _weight,
                    decoration: InputDecoration(
                      labelText: "Weight in kgs",
                      contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                      icon: Icon(Icons.line_weight),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(22.0)),
              Expanded(
                child: RaisedButton(
                  onPressed: () {
                    clearInput();
                  },
                  color: Colors.redAccent.shade200,
                  child: Text(
                    "Clear",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(15.0)),
              Expanded(
                child: RaisedButton(
                  onPressed: () {
                    calculate();
                  },
                  color: Colors.greenAccent,
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
          child: Text(
            _result,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25.0,
              color: _color
            ),
          ),
        )
      ],
    );
  }
}
