import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? db;

  Future<Database?> checkDB() async {
    if (db != null) {
      return db;
    } else {
      return await initDB();
    }
  }

  Future<Future<Database>> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "category.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)";
        String queryTransaction =
            "CREATE TABLE trac (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,time TEXT,date TEXT,category TEXT,status INTEGER)";
        db.execute(query);
        db.execute(queryTransaction);
      },
    );
  }

  Future<void> insertCategory(String category) async {
    db = await checkDB();
    String query = "INSERT INTO category (name) VALUES ('$category')";
    db!.rawInsert(query);
    print("=====================================$query");
  }

  Future<List<Map>> readCategory() async {
    db = await checkDB();
    String query = "SELECT * FROM category WHERE id";
    List<Map> data = await db!.rawQuery(query);

    return data;
  }

  Future<void> deleteCategory(int id) async {
    db = await checkDB();
    String query = "DELETE FROM category WHERE id = $id";
    db!.rawDelete(query);
  }

  Future<void> updateCategory(String name, int id) async {
    db = await checkDB();
    String query = "UPDATE category SET name = '$name' WHERE id = '$id'";
    db!.rawUpdate(query);
  }
}
