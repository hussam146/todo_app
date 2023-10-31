// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/features/task/data/model/task_model.dart';



const tableName = 'tasks';
class SqfliteHelper {
  // singleton instance
  SqfliteHelper._internal();
  static final SqfliteHelper _instance = SqfliteHelper._internal();
  factory SqfliteHelper() => _instance;

  late Database _database;

  // if it is found open it, else create it.
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "todoApp.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            note TEXT,
            startTime TEXT,
            endTime TEXT,
            date TEXT,
            isCompleted INTEGER,
            color INTEGER
          )
          ''').then((value) => log("db created successfully"));
      },
      onOpen: (db) => log("db opened successfully"),
      onUpgrade: (db, oldVersion, newVersion){
        // ALTER
        // assign a new version for your table
      }, 
    ).then((value) => _database = value);
  }

  Future<int> writeData(TaskModel taskModel) async {
    Database db = await database;

    return await db.rawInsert('''
      INSERT INTO $tableName(
        title,
        note,
        startTime,
        endTime,
        date, 
        isCompleted,
        color
      ) VALUES(
        '${taskModel.title}', 
        '${taskModel.note}',
        '${taskModel.startTime}',
        '${taskModel.endTime}',
        '${taskModel.date}',
        '${taskModel.isCompleted}',
        '${taskModel.color}')    ''');
  }

  Future<List<Map<String, dynamic>>> readData() async {
    Database db = await database;
    return await db.rawQuery('SELECT * FROM $tableName');
  }

  Future<int> updateData(int id) async {
    Database db = await database;
    return await db.rawInsert('''
      UPDATE $tableName
      SET isCompleted = ?
      WHERE id = ?
      ''', [1, id]);
      // default value for isCompleted variable is 0.
  }

  Future<int> deleteData(int id) async {
    Database db = await database;
    return await db.rawDelete('''
      DELETE FROM $tableName
      WHERE id = ?
      ''', [id]);
  }
  // ->  
  // upload data to server if there is an internet connection.
  uploadProduct(){
    // body
    // headers
    // encode response 
    // decode response
  }
  // gather data when there no internet connection then auto fetch them when connected to the internet.
  syncProduct(){
    // create another table contains data from first table.
    // get them from your db then delete them.
  }
}
