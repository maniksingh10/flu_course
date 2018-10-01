import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomButtonState();
  }
}

class CustomButtonState extends State<CustomButton> {
  int _a = 0;
  Color color = Colors.greenAccent;
  void add() {
    setState(() {
      _a += 1000;

      color = _a > 10000 ? Colors.redAccent : Colors.greenAccent;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(16.0),
              child: Text(
                '\$$_a',
                style: TextStyle(
                    color: color, fontSize: 40.0, fontWeight: FontWeight.w800),
              )),
          Container(
            margin: EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: add,
              child: Text("Button"),
              animationDuration: Duration(seconds: 2),
              color: color,
              highlightColor: Colors.greenAccent,
              elevation: 5.0,
            ),
          )
        ],
      ),
    );
  }
}

