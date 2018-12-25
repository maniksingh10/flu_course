import 'package:flutter/material.dart';

class NoDoItem extends StatelessWidget {
  String _itemName;
  String _dateCreated;
  int _id;

  NoDoItem(this._dateCreated, this._itemName);

  NoDoItem.map(dynamic obj) {
    this._dateCreated = obj['dateCreated'];
    this._itemName = obj['itemName'];
    this._id = obj["id"];
  }

  String get itemNameG => _itemName;
  String get dateCreatedG => _dateCreated;
  int get idG => _id;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["dateCreated"] = _dateCreated;
    map["itemName"] = _itemName;
    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }

  NoDoItem.fromMap(Map<String, dynamic> obj) {
    this._dateCreated = obj['dateCreated'];
    this._itemName = obj["itemName"];
    this._id = obj["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _itemName,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(_dateCreated,
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700)),
              )
            ],
          )
        ],
      ),
    );
  }
}
