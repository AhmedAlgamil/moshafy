import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshafy/modules/home_page_screen/presentation/cubit/home_page_states.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/constatnts/constants.dart';
import '../../../core/local/shared_prefrence.dart';
import '../../home_page_screen/data/repository/local_repository.dart';
import 'loading_states.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit(this.localRepository) : super(LoadingInitialState());

  static LoadingCubit get(BuildContext context) => BlocProvider.of(context);

  late LocalRepository localRepository;
  int surahProgress=0,ayahProgress=0,hadeethProgress=0,azkarProgress=0,tasbeehProgress=0;

  late Database dataBaseQuran;


  Future<void> setUpDataBase() async {
    await openDatabase(
      "quranDataBase.db",
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
          "CREATE TABLE surah_table ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "number TEXT,"
              "surah_name TEXT,"
              "surahEnglishName TEXT,"
              "surahEnglishNameTranslation  TEXT,"
              "numberOfAyahs TEXT,"
              "revelationType TEXT,"
              "surah_page TEXT,"
              "is_favourited TEXT)",
        )
            .then((value) {
          print("surah_table Created");
        });
        database
            .execute(
          "CREATE TABLE ayah_table ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "number TEXT,"
              "textAyah TEXT,"
              "numberInSurah TEXT,"
              "juz TEXT,"
              "manzil TEXT,"
              "page TEXT,"
              "ruku TEXT,"
              "hizbQuarter TEXT,"
              "surahNumber TEXT,"
              "is_favourited TEXT)",
        )
            .then(
              (value) {
            print("ayah_table Created");
          },
        );

        database
            .execute(
          "CREATE TABLE favourit_table ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "type_id TEXT,"
              "favourite_text TEXT,"
              "type_text TEXT)",
        )
            .then((value) {
          print("favourit_table Created");
        });

        database
            .execute(
          "CREATE TABLE hadeeth_table ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "hadeeth_text TEXT,"
              "is_favourited TEXT)",
        )
            .then(
              (value) {
            print("hadeeth_table Created");
          },
        );
        database
            .execute(
          "CREATE TABLE tasbeeh_table ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "tasbeeh_text TEXT,"
              "total_count TEXT,"
              "counter TEXT,"
              "notes TEXT,"
              "is_favourited TEXT)",
        )
            .then(
              (value) {
            print("tasbeeh_table Created");
          },
        );
        database
            .execute(
          "CREATE TABLE azkar_table ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "azkar_title TEXT,"
              "azkar_text TEXT,"
              "total_count TEXT,"
              "counter TEXT,"
              "notes TEXT,"
              "is_favourited TEXT)",
        )
            .then(
              (value) {
            print("azkar_table Created");
          },
        );
      },
      onOpen: (database) {
        print("database opened");
        emit(LoadingInitialState());
      },
    ).then((value) {
    }).catchError((error) {
      print(error.toString());
    });
  }


  Future<void> insertSurahToDB() async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    for (int i = 0; i < Constants.surahDataArray.length; i++) {
      await dataBaseQuran.transaction((txn) {
        return txn.rawInsert(Constants.surahDataArray[i]);
      });
      surahProgress++;
    }
    emit(SurahDataLoadedSuccessfully());
  }

  Future<void> insertHadeethToDB() async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    for (int i = 0; i < Constants.hadeethDataArray.length; i++) {
      await dataBaseQuran.transaction((txn) {
        return txn.rawInsert(Constants.hadeethDataArray[i]);
      });
      if (i == Constants.hadeethDataArray.length - 1) {
        AppSharedPrefrence.setString(
            Constants.DATAINSERTED, Constants.DATAINSERTED);
      }
      hadeethProgress++;
    }
    emit(HadeethDataLoadedSuccessfully());
  }
  Future<void> insertAzkarToDB() async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    for (int i = 0; i < Constants.azkarkDataArray.length; i++) {
      await dataBaseQuran.transaction((txn) {
        return txn.rawInsert(Constants.azkarkDataArray[i]);
      });
      if (i == Constants.azkarkDataArray.length - 1) {
        AppSharedPrefrence.setString(
            Constants.DATAINSERTED, Constants.DATAINSERTED);
      }
      azkarProgress++;
    }
    emit(AzkarDataLoadedSuccessfully());
  }
  Future<void> insertTasbeehToDB() async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    for (int i = 0; i < Constants.tasbeehDataArray.length; i++) {
      await dataBaseQuran.transaction((txn) {
        return txn.rawInsert(Constants.tasbeehDataArray[i]);
      });
      if (i == Constants.tasbeehDataArray.length - 1) {
        AppSharedPrefrence.setString(
            Constants.DATAINSERTED, Constants.DATAINSERTED);
      }
      tasbeehProgress++;
    }
    emit(TasbeehDataLoadedSuccessfully());
  }

  Future<void> insertAyahToDB() async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    for (int i = 0; i < Constants.ayahDataArray.length; i++) {
      await dataBaseQuran.transaction((txn) {
        return txn.rawInsert(Constants.ayahDataArray[i]);
      });
      ayahProgress++;
    }
    emit(AyahDataLoadedSuccessfully());
  }

  Future<void> requestFileManger()
  async => await FileManager.requestFilesAccessPermission();
}
