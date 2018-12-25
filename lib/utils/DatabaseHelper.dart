import 'dart:async';
import 'dart:io';
import 'package:flu_course/item/list_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance_my = DatabaseHelper.internal();
  final String _tableName = "NoToDoTable";
  final String _columnId = "id";
  final String _columnlist_itemname = "itemName";
  final String _dateCreated = "dateCreated";

  factory DatabaseHelper() => _instance_my;

  static Database _dbmy;

  Future<Database> get db async {
    if (_dbmy != null) {
      return _dbmy;
    }
    _dbmy = await _initDb();
    return _dbmy;
  }

  DatabaseHelper.internal();

  _initDb() async {
    Directory directoryDocs = await getApplicationDocumentsDirectory();
    String path = join(directoryDocs.path, "ManikDB.db");
    var our_db = openDatabase(path, version: 1, onCreate: _onCreatemy);
    return our_db;
  }

  void _onCreatemy(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_tableName($_columnId INTEGER PRIMARY KEY, $_columnlist_itemname TEXT, $_dateCreated TEXT)");
  }

  Future<int> addlist_itemmy(NoDoItem list_item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$_tableName", list_item.toMap());
    return res;
  }

  Future<List> getalllist_items() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $_tableName");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClinen = await db;
    return Sqflite.firstIntValue(
        await dbClinen.rawQuery("SELECT COUNT(*) FROM $_tableName "));
  }

  Future<NoDoItem> getlist_item(int id) async{
    var dbclinet = await db;
    var result = await dbclinet.rawQuery("SELECT * FROM $_tableName WHERE $_columnId = $id");

    if(result == 0){
      return null;
    }else{
       return NoDoItem.fromMap(result.first);
    }
  }

  Future<int> dellist_item(int id)async{
    var dbclint = await db;
    var result = await dbclint.delete(_tableName,where:"$_columnId = ?", whereArgs: [id]);

    return result;
  }
  
  Future<int> updatelist_item(NoDoItem list_item) async{
    var dbclinet = await db;
    var result = dbclinet.update(_tableName, list_item.toMap(),where: "$_columnId = ?",whereArgs: [list_item.idG]);
    return result;
  }

  Future close() async{
    var dbclinet= await db;
    return dbclinet.close();
  }
}