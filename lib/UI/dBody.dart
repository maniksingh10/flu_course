import 'package:flutter/material.dart';

class MyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(16.0),
              child: Text(
                "This is the Body 1",
                style: TextStyle(color: Colors.black, fontSize: 40.0),
              )),
          Container(
              margin: EdgeInsets.all(16.0),
              child: Text(
                "This is the Body 2",
                style: TextStyle(color: Colors.black, fontSize: 40.0),
              )),
          Container(
              margin: EdgeInsets.all(16.0),
              child: Text(
                "This is the Body 3",
                style: TextStyle(color: Colors.black, fontSize: 40.0),
              )),
          Container(margin: EdgeInsets.all(16.0), child: CustomButton()),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackbar = SnackBar(
          content: Text("Button Press"),
          backgroundColor: Colors.greenAccent.shade400,
          duration: Duration(seconds: 2),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.greenAccent.shade200,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(blurRadius: 10.0, color: Colors.purple)
            ]),
        child: Text(
          "Press Button",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
