import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? db;

  Future<Database> checkDB() async {
    if (db != null) {
      return db!;
    } else {
      return await creatDB();
    }
  }

  Future<Database> creatDB() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, "rnw.db");

    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query =
          "CREATE TABLE std(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,mobile TEXT,photo BLOB)";
      db.execute(query);
    });
  }

  void insertData(String name, String mobile, Uint8List photo) async {
    db = await checkDB();
    db!.insert("std", {"name": name, "mobile": mobile, "photo": photo});
  }

  Future<List<Map>> readData() async {
    db = await checkDB();
    String query = "SELECT* FROM std";
    List<Map> l1 = await db!.rawQuery(query, null);
    return l1;
  }
}
