import 'package:flu_course/utils/User.dart';
import 'package:flutter/material.dart';
import "utils/DatabaseHelper.dart";

List _allUsers;
void main() async {
  var db = DatabaseHelper();

  int count = await db.getCount();
  print("Total users are $count");
  int res = await db.delUser(35);
  print("$res");
  int added = await db.addUsermy(User("test", "test123"));

  _allUsers = await db.getallUsers();
  for (int i = 0; i < _allUsers.length; i++) {
    User user = User.map(_allUsers[i]);
    print("${user.id} ${user.username} ${user.password}");
  }

  runApp(MaterialApp(
    title: "Sqlite",
    home: SQL_App(),
  ));
}

class SQL_App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQL_App"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView.builder(
        itemCount: _allUsers.length,
        itemBuilder: (_, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(
                "User = ${User.fromMap(_allUsers[position]).username}",
                style: sty(),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                "Id = ${User.fromMap(_allUsers[position]).id}",
                style: sty(),
                textAlign: TextAlign.center,
              ),
              leading: CircleAvatar(
                child: Text(
                    "${User.fromMap(_allUsers[position]).username.substring(0, 1)}"),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

TextStyle sty() {
  return TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500);
}
