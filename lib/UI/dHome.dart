import 'package:flutter/material.dart';
import './dBody.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScafPrac"),
        backgroundColor: Colors.greenAccent.shade400,
        elevation: 6.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.alarm),
              onPressed: () => debugPrint("Alarm Tapped")),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () => debugPrint("Message Tapped"),
          )
        ],
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.account_box),
        onPressed: () => debugPrint("FAB Tapped"),
        tooltip: "FAB",
      ),
      body: CustomButton(),
      backgroundColor: Colors.greenAccent.shade50,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text("Map"),
              icon: Icon(Icons.map),
              backgroundColor: Colors.greenAccent),
          BottomNavigationBarItem(title: Text("Help"), icon: Icon(Icons.help)),
          BottomNavigationBarItem(
              title: Text("Healing"), icon: Icon(Icons.healing))
        ],
        onTap: (int i) => debugPrint("Touched $i"),
      ),
    );
  }
}
