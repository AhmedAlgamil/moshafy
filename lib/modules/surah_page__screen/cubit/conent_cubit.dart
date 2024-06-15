import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'content_states.dart';

class ContentPageCubit extends Cubit<ContentStates> {
  ContentPageCubit() : super(ContentInitialState());

  static ContentPageCubit get(BuildContext context) => BlocProvider.of(context);

  List<Map<String, dynamic>>? allDBSurah = [];
  List<Map<String, dynamic>>? allDBAyah = [];

  Database? dataBaseQuran;

  Future<void> startDatabase() async {
    await openDatabase(
      // "quranDataBase.db",
      "quranDataBase.db",
      onOpen: (db) {
        dataBaseQuran = db;
        selectFromDatabase(db);
        emit(DataBaseOpendState());
        print("database Opened");
      },
    );
  }

  void selectFromDatabase(Database db) async {
    allDBSurah = [];
    await db.transaction(
      (txn) {
        return txn.query(
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
            "is_favourited",
          ],
        ).then(
          (value) {
            allDBSurah = value;
            print(allDBSurah!.length);
            emit(SurahLoadStates());
          },
        ).catchError((error) {
          print(error);
        });
      },
    ).catchError((error) {
      print(error.toString());
    });
  }

  void setFavourite({String? is_favourited, int? id}) async {
    await dataBaseQuran!.rawUpdate(
        'UPDATE surah SET is_favourited = ? WHERE id = ?',
        [is_favourited, '$id']).then((value) {
      selectFromDatabase(dataBaseQuran!);
      emit(SetFavouriteSurahState());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
