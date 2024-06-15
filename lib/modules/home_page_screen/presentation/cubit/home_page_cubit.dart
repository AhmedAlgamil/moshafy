import 'dart:io' as io;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/constatnts/constants.dart';
import '../../../../core/database_heper/database_helper.dart';
import '../../../../core/local/cach_helper.dart';
import '../../../../core/local/shared_prefrence.dart';
import '../../../../generated/assets.dart';
import 'package:path/path.dart' as path;
import '../../data/model/ayah.dart';
import '../../data/model/favourite_model.dart';
import '../../data/model/hadeeth.dart';
import '../../data/model/surah.dart';
import 'home_page_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class HomePageCubit extends Cubit<AppStates> {
  HomePageCubit() : super(AppInitialState());

  static HomePageCubit get(BuildContext context) => BlocProvider.of(context);

  List<Surah>? allSurah = [];
  List<Map<String, dynamic>>? allDBSurah = [];
  List<Ayah>? allAyah = [];
  List<Map<String, dynamic>>? allDBAyah = [];

  List<Ayah>? allAyahPage = [];

  Database? dataBaseQuran;

  bool isClosed = false;

  List<Hadeeth> allHadeeth = [];

  late final AppLifecycleListener listener;
  final ScrollController scrollController = ScrollController();
  final List<String> states = <String>[];
  late AppLifecycleState? myState;

  bool _shouldExit = false;
  String _lastExitResponse = 'No exit requested yet';

  int indexStates = 0;

  List<FavouriteModel> favItems = [
    FavouriteModel(
        id: 1, favType: "مصحف", titleFavouted: "سُورَةُ ٱلْفَاتِحَةِ"),
    FavouriteModel(
        id: 2,
        favType: "حديث",
        titleFavouted:
            "قال الرّسول -صلّى الله عليه وسلّم-: (لو كانتِ الدُّنيا تعدلُ عندَ اللهِ جناحَ بعوضةٍ ما سقى كافرًا منها شربةَ ماءٍ)"),
    FavouriteModel(
        id: 3,
        favType: "آية",
        titleFavouted: "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ"),
    FavouriteModel(
        id: 4, favType: "مصحف", titleFavouted: "سُورَةُ الأَنۡعَامِ"),
    FavouriteModel(
        id: 5,
        favType: "حديث",
        titleFavouted:
            "قال الرّسول -صلّى الله عليه وسلّم-: (من كانتِ الآخرةُ هَمَّهُ جعلَ اللَّهُ غناهُ في قلبِهِ وجمعَ لَه شملَهُ وأتتهُ الدُّنيا وَهيَ راغمة، ومن كانتِ الدُّنيا همَّهُ جعلَ اللَّهُ فقرَهُ بينَ عينيهِ وفرَّقَ عليهِ شملَهُ، ولم يأتِهِ منَ الدُّنيا إلَّا ما قُدِّرَ لَهُ)"),
    FavouriteModel(
        id: 6,
        favType: "آية",
        titleFavouted:
            "وَإِذْ قُلْنَا ٱدْخُلُوا۟ هَٰذِهِ ٱلْقَرْيَةَ فَكُلُوا۟ مِنْهَا حَيْثُ شِئْتُمْ رَغَدًۭا وَٱدْخُلُوا۟ ٱلْبَابَ سُجَّدًۭا وَقُولُوا۟ حِطَّةٌۭ نَّغْفِرْ لَكُمْ خَطَٰيَٰكُمْ ۚ وَسَنَزِيدُ ٱلْمُحْسِنِينَ"),
  ];

  List<String> titles = [
    "المصحف",
    "الأحاديث",
    "المفضلة",
    "القبلة",
    "الإعدادات",
  ];

  PageController controller = PageController(initialPage: 0);
  PageController navBarController = PageController(initialPage: 0);
  int pageNavNumber = 0;
  int surahProgress = 0, ayaProgress = 0;

  void changePageView(int index) {
    controller.animateToPage(index,
        duration: const Duration(seconds: 1),
        curve: Curves.fastEaseInToSlowEaseOut);
    getAyahsPage(index);
    emit(PageViewChangeState());
  }

  Future<void> setupDB() async {
    openDatabase(
      "quranDataBase.db",
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
          "CREATE TABLE surah ("
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
          print("surah Created");
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
            print("Ayah Created");
          },
        );
      },
      onOpen: (database) {
        print("database opened");
      },
    ).then((value) {
      dataBaseQuran = value;
      insertSurahToDB();
    }).catchError((error) {
      print(error.toString());
    });
  }

  void setupAppLifyCycle() {
    myState = SchedulerBinding.instance.lifecycleState;
    listener = AppLifecycleListener(
      // Event handlers...
      onShow: () => _handleTransition('show'),
      onResume: () => _handleTransition('resume'),
      onHide: () => _handleTransition('hide'),
      onInactive: () => _handleTransition('inactive'),
      onPause: () => _handleTransition('pause'),
      onDetach: () => _handleTransition('detach'),
      onRestart: () => _handleTransition('restart'),
      onExitRequested: _handleExitRequest,
      // This fires for each state change. Callbacks above fire only for
      // specific state transitions.
      onStateChange: _handleStateChange,
    );
    if (myState != null) {
      states.add(myState!.name);
    }
  }

  Future<AppExitResponse> _handleExitRequest() async {
    final AppExitResponse response =
        _shouldExit ? AppExitResponse.exit : AppExitResponse.cancel;
    _lastExitResponse = 'App responded ${response.name} to exit request';
    return response;
  }

  void _handleTransition(String name) {
    if (name == 'detach') {
    } else if (name == 'resume') {
      setupDB();
    }
  }

  void _handleStateChange(AppLifecycleState myState) {
    myState = myState;
    emit(AppLifeCycleStateChange());
  }

  Future<void> insertSurahToDB() async {
    for (int i = 0; i < Constants.surahDataArray.length; i++) {
      await dataBaseQuran?.transaction((txn) {
        return txn.rawInsert(Constants.surahDataArray[i]);
      }).then((value) {
        isClosed = true;
        surahProgress = i;
      }).catchError((error) {
        print(error);
      });
    }
    insertAyahToDB();
  }

  Future<void> insertAyahToDB() async {
    for (int i = 0; i < Constants.ayahDataArray.length; i++) {
      await dataBaseQuran?.transaction((txn) {
        return txn.rawInsert(Constants.ayahDataArray[i]);
      }).then((value) {
        print("inserted $value ");
        isClosed = true;
        ayaProgress = i;
      }).catchError((error) {
        print(error);
      });
    }
    if (ayaProgress == 6236) {
      emit(DataInsertedState());
    }
    AppSharedPrefrence.setString(
        Constants.DATAINSERTED, Constants.DATAINSERTED);
  }

  Future<void> startDatabase() async {
    openDatabase(
      // "quranDataBase.db",
      "quranDataBase.db",
      onOpen: (db) {
        dataBaseQuran = db;
        selectFromDatabase(db);
        emit(DataBAseOpendState());
        print("database Opened");
      },
    );
    emit(LoadAllAyahsState());
  }

  void selectFromDatabase(Database db) async {
    allDBSurah = [];
    allDBAyah = [];
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
            emit(RetriveFromDatatBase());
          },
        ).catchError((error) {
          print(error);
        });
      },
    ).catchError(onError);
  }

  Future<Map<String, dynamic>> selectSpecificFromDatabase(
    Database db,
    int? id,
  ) async {
    Map<String, dynamic> result = {};
    await db.transaction(
      (txn) {
        return txn
            .query("surah",
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
                where: "id = $id")
            .then(
          (value) {
            for (var element in value) {
              result = element;
              print(result["surah_name"]);
              print(result["is_favourited"]);
              // allDBSurah!.add(element);
            }
            emit(RetriveFromDatatBase());
          },
        ).catchError((error) {
          print(error);
        });
      },
    ).catchError(onError);
    return result;
  }

  Future<void> getSurahss() async {
    allSurah = await QuaranDataBaseHelper.getAllSurahs();
    print(allSurah);
    emit(SurahLoadStates());
  }

  Future<void> test() async {
    openDatabase(
      "quranDataBase.db",
      onOpen: (db) async {
        allDBSurah = [];
        await dataBaseQuran?.rawQuery("SELECT * FROM surah").then((value) {
          for (var element in value) {
            allDBSurah!.add(element);
            print(element);
          }
          emit(RetriveFromDatatBase());
          print(allDBSurah);
        }).catchError((error) {
          print(error.toString());
        });
      },
    );
  }

  void changePageViewNaveBar(int index, {bool isClicked = false}) {
    if (isClicked) {
      navBarController.animateToPage(index,
          duration: const Duration(seconds: 1),
          curve: Curves.fastEaseInToSlowEaseOut);
    }
    pageNavNumber = index;
    emit(PageViewChangeState());
  }

  void getAyahsPage(int pageIndex) async {
    // if (allAyahPage != null) allAyahPage!.clear();
    for (int i = 0; i < allAyah!.length; i++) {
      if (pageIndex == int.parse(allAyah![i].page!)) {
        allAyahPage!.add(allAyah![i]);
        print("${allAyahPage![i].textAyah} ${allAyahPage![i].number} ");
      }
    }
    // Map the dynamic List to List<User>
    emit(LoadPageAyahsState());
  }

  void setFavourite({String? is_favourited, int? id}) async {
    await dataBaseQuran!.rawUpdate(
        'UPDATE surah SET is_favourited = ? WHERE id = ?',
        [is_favourited, '$id']).then((value) {
      selectFromDatabase(dataBaseQuran!);
      emit(SetFavouriteState());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
