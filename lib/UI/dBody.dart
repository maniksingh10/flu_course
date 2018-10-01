import 'package:flutter/material.dart';

class MyAppBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppBodyState();
  }
}

class MyAppBodyState extends State<MyAppBody> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String _name = "";
  String _pass;
  void clear() {
    setState(() {
      _userController.clear();
      _passController.clear();
    });
  }

  void getString() {
    setState(() {
      if (_passController.text.isNotEmpty && _userController.text.isNotEmpty) {
        _name = _userController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(16.0)),
          Image.asset(
            "images/imgface.png",
            width: 120.0,
            height: 120.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16.0, 36.0, 16.0, 16.0),
            width: 400.0,
            height: 180.0,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    autocorrect: false,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                    controller: _userController,
                    decoration: InputDecoration(
                      
                      labelText: "Username",
                      icon: Icon(Icons.person_add),
                      contentPadding: EdgeInsets.symmetric(vertical: 3.0),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                    obscureText: true,
                    controller: _passController,
                    decoration: InputDecoration(
                        
                        labelText: "Password",
                        icon: Icon(Icons.lock),
                        contentPadding: EdgeInsets.symmetric(vertical: 3.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(14.0),
                ),
                Center(
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 30.0),
                          child: RaisedButton(
                            onPressed: clear,
                            child: Text("Clear",
                                style: TextStyle(color: Colors.white)),
                            color: Colors.red,
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 120.0),
                          child: RaisedButton(
                            onPressed: getString,
                            child: Text("Login",
                                style: TextStyle(color: Colors.white)),
                            color: Colors.greenAccent.shade400,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(30.0)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(
              "😃 Welcome To My App 😃\n$_name",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
              ),
            )
          ])
        ],
      ),
    );
  }
}
