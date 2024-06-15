import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';

class TestDBHelper {
  Future initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,"quran.db");
    final exist = await databaseExists(path);
  }
}
