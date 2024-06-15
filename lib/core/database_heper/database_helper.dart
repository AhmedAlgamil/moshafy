import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';

import '../../modules/home_page_screen/data/model/surah.dart';

class QuaranDataBaseHelper {
  static Database? _db;

  static Future<void> init() async {
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();

    String dbPathEnglish = path.join(applicationDirectory.path, "quran.db");

    bool dbExistsEnglish = await io.File(dbPathEnglish).exists();

    if (!dbExistsEnglish) {
      // Copy from asset
      ByteData data =
          await rootBundle.load(path.join("assets/database/", "quran.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }

    await openDatabase(dbPathEnglish, version: 3)
        .then(
      (value) {
        _db = value;
      },
    )
        .catchError((error) {
      print(error.toString());
    });
    print(_db);
  }

  /// get all the words from english dictionary
  static Future<List<Surah>> getAllSurahs() async {
    if (_db == null) {
      throw "db is not initiated, initiate using [init(db)] function";
    }
    List<Map>? words;

    await _db!.transaction((txn) async {
      words = await txn.query(
        "surah",
        columns: [
          "id",
          "number",
          "surah_name",
          "surahEnglishName",
          "surahEnglishNameTranslation",
          "numberOfAyahs",
          "revelationType",
          "surah_page",
        ],
      );
    });

    return words!.map((e) => Surah.fromJson(e)).toList();
  }

// you can use this function to get the database from the internet
// Future<void> init() async {
//   io.Directory applicationDirectory =
//   await getApplicationDocumentsDirectory();
//
//   String dbPathEnglish =
//   path.join(applicationDirectory.path, "englishDictionary.db");
//
//   bool dbExistsEnglish = await io.File(dbPathEnglish).exists();
//
//   if (!dbExistsEnglish) {
//     String url = "https://this/is/the/url/to/your/db/eng_dictionary.db";
//
//     var httpClient = new io.HttpClient();
//     var request = await httpClient.getUrl(Uri.parse(url));
//     var response = await request.close();
//
//     // thow an error if there was error getting the file
//     // so it prevents from wrting the wrong content into the db file
//     if (response.statusCode != 200) throw "Error getting db file";
//
//     var bytes = await consolidateHttpClientResponseBytes(response);
//
//     io.File file = new io.File(dbPathEnglish);
//     await file.writeAsBytes(bytes);
//   }
//
//   this._db = await openDatabase(dbPathEnglish);
// }
}
