import 'package:flu_course/model/board.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Firebase',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Board> allBoardmsg = List();
  Board board;
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    board = Board("", "");
    databaseReference = firebaseDatabase.reference().child("com_board");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Firebase"),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 0,
              child: Center(
                child: Form(
                  key: formKey,
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.subject),
                        title: TextFormField(
                          initialValue: "",
                          onSaved: (val) => board.subject = val,
                          validator: (val) => val == "" ? val : null,
                          decoration:
                              InputDecoration(labelText: "Whats Your Subject?"),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.message),
                        title: TextFormField(
                          initialValue: "",
                          onSaved: (val) => board.body = val,
                          validator: (val) => val == "" ? val : null,
                          decoration:
                              InputDecoration(labelText: "Whats Your Message?"),
                        ),
                      ),
                      FlatButton(
                        onPressed: () => _handleSubmit(),
                        child: Text("Post"),
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: FirebaseAnimatedList(
                query: databaseReference,
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          allBoardmsg[index].subject.substring(0, 1),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(allBoardmsg[index].subject),
                      subtitle: Text(allBoardmsg[index].body),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  void _onEntryAdded(Event event) {
    setState(() {
      allBoardmsg.add(Board.fromSnapshot(event.snapshot));
    });
  }

  void _handleSubmit() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();

      databaseReference.push().set(board.toJsom());
    }
  }


  void _onEntryUpdated(Event event) {
    var oldEntery = allBoardmsg.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      allBoardmsg[allBoardmsg.indexOf(oldEntery)] =
          Board.fromSnapshot(event.snapshot);
    });
  }
}
