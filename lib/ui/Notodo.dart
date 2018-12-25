import 'package:flu_course/item/list_item.dart';
import 'package:flu_course/utils/DatabaseHelper.dart';
import 'package:flu_course/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class NoToDoScreen extends StatefulWidget {
  @override
  _NoToDoScreenState createState() => _NoToDoScreenState();
}

class _NoToDoScreenState extends State<NoToDoScreen> {
  var _textEditController = TextEditingController();
  var db = DatabaseHelper();
  final List<NoDoItem> _itemList = <NoDoItem>[];

  @override
  void initState() {
    super.initState();
    _readAllList();
  }

  void _submitItem(String text) async {
    _textEditController.clear();
    NoDoItem noDoItem = NoDoItem(dateFormatted(), text);

    int savedItem = await db.addlist_itemmy(noDoItem);
    Navigator.pop(context);

    NoDoItem addedItem = await db.getlist_item(savedItem);

    setState(() {
      _itemList.insert(0, addedItem);
    });
    print("Item Saved at $savedItem");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormDialog,
        tooltip: "Add",
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder: (_, int index) {
                return Card(
                  child: ListTile(
                    title: _itemList[index],
                    onLongPress: () => _updateItem(_itemList[index], index),
                    trailing: Listener(
                      key: Key(_itemList[index].itemNameG),
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onPointerDown: (PointerEvent) =>
                          _deleteItem(_itemList[index].idG, index),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(
            height: 1.0,
          )
        ],
      ),
    );
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Item",
                  hintText: "What Not To Do?",
                  icon: Icon(Icons.note_add)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _submitItem(_textEditController.text);
          },
          child: Text("Add"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _readAllList() async {
    List all = await db.getalllist_items();

    all.forEach((item) {
      NoDoItem noDoItem = NoDoItem.fromMap(item);
      setState(() {
        _itemList.add(NoDoItem.map(item));
      });
      print(
          "${noDoItem.itemNameG.toString()} and ${noDoItem.dateCreatedG.toString()}");
    });
  }

  _deleteItem(int idG, int index) async {
    await db.dellist_item(idG);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  _updateItem(NoDoItem item, int index) {
    var alert = AlertDialog(
      title: Text("Update"),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Item",
                  hintText: "What Not To Do?",
                  icon: Icon(Icons.update)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            NoDoItem updatedItem = NoDoItem.fromMap({
              "itemName": _textEditController.text,
              "dateCreated": dateFormatted(),
              "id": item.idG
            });
            _submitUpdated(index, item);
            await db.updatelist_item(updatedItem);
            setState(() {
              _readAllList();
            });
            _textEditController.clear();
            Navigator.pop(context);
          },
          child: Text("Update"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _submitUpdated(int index, NoDoItem item) {
    setState(() {
      _itemList.removeWhere((element) {
        _itemList[index].itemNameG == item.itemNameG;
      });
    });
  }
}
