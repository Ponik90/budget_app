import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
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
            "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,image BLOB)";
        String query2 =
            "CREATE TABLE trans (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount TEXT,time TEXT,date TEXT,category TEXT,status INTEGER)";
        db.execute(query);
        db.execute(query2);
      },
    );
  }

  Future<void> insertCategory(String category, String path) async {
    db = await checkDB();
    File data = File(path);
    Uint8List bytes = await data.readAsBytes();
    String image = base64Encode(bytes);
    String query =
        "INSERT INTO category (name,image) VALUES ('$category','$image')";
    db!.rawInsert(query);
  }

  Future<List<Map>> readCategory() async {
    db = await checkDB();
    String query = "SELECT * FROM category";
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

  Future<void> insertTransaction(String title, String time, String date,
      String amount, String category, int status) async {
    db = await checkDB();
    String query =
        "INSERT INTO trans (title,time,date,amount,status,category) VALUES ('$title','$time','$date','$amount','$status','$category')";
    db!.rawInsert(query);
  }

  Future<List<Map>> readTransaction() async {
    db = await checkDB();
    String query = "SELECT * FROM trans";
    List<Map> data = await db!.rawQuery(query);
    return data;
  }

  Future<void> updateTransaction(
    int id,
    String title,
    String amount,
    String time,
    String date,
    String category,
  ) async {
    db = await checkDB();
    String query =
        "UPDATE trans SET title = '$title',time = '$time',date = '$date',category = '$category', amount = '$amount' WHERE id  = '$id'";

    db!.rawUpdate(query);
  }

  Future<void> deleteTransaction(int id) async {
    db = await checkDB();
    String query = "DELETE FROM trans WHERE id =  $id";
    db!.rawDelete(query);
  }

  Future<List<Map>> filterTransaction(int data) async {
    db = await checkDB();
    String query = "SELECT * FROM trans WHERE status = $data";
    List<Map> filter = await db!.rawQuery(query);
    return filter;
  }
}
