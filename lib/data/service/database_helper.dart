import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class DBHelper {
  static Database? _database;

  static Future<void> initDatabase() async {
    if (_database != null) return;

    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "tanchangya_dictionary.db");

      // Check if the database already exists
      bool exists = await databaseExists(path);

      if (!exists) {
        // Copy from assets
        ByteData data = await rootBundle.load(join("assets", "tanchangya_dictionary.db"));
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(path).writeAsBytes(bytes);
      }

      // Open the database
      _database = await openDatabase(path);
      print("Database initialized at $path");
    } catch (e) {
      print("Error initializing database: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> getAllWords() async {
    if (_database == null) await initDatabase();
    try {
      return await _database!.query('bangladic');
    } catch (e) {
      print("Error querying database: $e");
      return [];
    }
  }


  static Future<List<Map<String, dynamic>>> queryWord(String word) async {
    if (_database == null) await initDatabase();
    try {
      return await _database!.query(
        'bangladic',
        where: 'word = ?',
        whereArgs: [word],
      );
    } catch (e) {
      print("Error querying database: $e");
      return [];
    }
  }
}
