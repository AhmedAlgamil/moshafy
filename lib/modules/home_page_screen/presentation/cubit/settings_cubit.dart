import 'dart:async';
import 'dart:io';

import 'package:file_manager/controller/file_manager_controller.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/local/shared_prefrence.dart';
import '../../data/model/ayah.dart';
import '../../data/repository/local_repository.dart';
import 'home_page_states.dart';

enum SortOrder { ascending, descending }

class SettingsCubit extends Cubit<AppStates> {
  SettingsCubit() : super(AppInitialState());


  double angle = 0.0;

  static SettingsCubit get(BuildContext context) => BlocProvider.of(context);
  List<Map<String, dynamic>>? allDBSurah = [];
  List<Map<String, dynamic>>? allDBAyah = [];
  List<Map<String, dynamic>>? allDBFavourit = [];
  List<Map<String, dynamic>>? allDBHadeeth = [];
  List<Map<String, dynamic>>? allDBAzkar = [];
  List<Map<String, dynamic>>? allDBTasbeeh = [];

  List<Map<String, dynamic>>? allAyahPage = [];

  late FileManagerController controller = FileManagerController();

  int switchNumber = 0;
  int? pageViewSize = 0;

  late LocalRepository localRepository = LocalRepository();

  Database? dataBaseQuran;
  ThemeMode themeMode = ThemeMode.system;

  List<Map<String, dynamic>>? searchResult = [];

  // late final AppLifecycleListener listener;
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController(initialPage: 0);

  Directory directory = Directory('/storage/emulated/0/moshafy');
  List<FileSystemEntity> files = [];
  bool loading = true;
  SortOrder sortOrder = SortOrder.ascending;

  // final List<String> states = <String>[];
  // late AppLifecycleState? myState;
  // int indexStates = 0;

  String switchValue = "";

  BuildContext? context;

  MagnetometerEvent magnetometerEvent = MagnetometerEvent(0, 0, 0);
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  Duration sensorInterval = SensorInterval.normalInterval;

  final List<bool> items = <bool>[true, true, true];

  PageController navBarController = PageController(initialPage: 0);
  int pageNavNumber = 0;
  int surahProgress = 0, ayaProgress = 0;

  Locale local = const Locale('ar');

  void setUpCompassMovment({bool isCompassClosed = true}) {
    if (isCompassClosed) {
      _streamSubscriptions.add(
        magnetometerEventStream(samplingPeriod: sensorInterval).listen(
          ((MagnetometerEvent event) {
            magnetometerEvent = event;
            print("X    ${magnetometerEvent.x}");
            print("Y    ${magnetometerEvent.y}");
          }),
        ),
      );
    } else {
      for (final subscription in _streamSubscriptions) {
        subscription.cancel();
      }
    }
  }

//setup LifeCycle
  // void setupAppLifyCycle() {
  //   myState = SchedulerBinding.instance.lifecycleState;
  //   listener = AppLifecycleListener(
  //     // Event handlers...
  //     onShow: () => _handleTransition('show'),
  //     onResume: () => _handleTransition('resume'),
  //     onHide: () => _handleTransition('hide'),
  //     onInactive: () => _handleTransition('inactive'),
  //     onPause: () => _handleTransition('pause'),
  //     onDetach: () => _handleTransition('detach'),
  //     onRestart: () => _handleTransition('restart'),
  //     onExitRequested: _handleExitRequest,
  //     // This fires for each state change. Callbacks above fire only for
  //     // specific state transitions.
  //     onStateChange: _handleStateChange,
  //   );
  //   if (myState != null) {
  //     states.add(myState!.name);
  //   }
  // }

  // Future<AppExitResponse> _handleExitRequest() async {
  //   final AppExitResponse response =
  //       _shouldExit ? AppExitResponse.exit : AppExitResponse.cancel;
  //   _lastExitResponse = 'App responded ${response.name} to exit request';
  //   return response;
  // }
  //
  // void _handleTransition(String name) {
  //   if (name == 'detach') {
  //   } else if (name == 'resume') {
  //     setupDB();
  //   }
  // }

  // void _handleStateChange(AppLifecycleState myState) {
  //   myState = myState;
  //   emit(AppLifeCycleStateChange());
  // }

  // end of setupLifeCycle

  // Future<Map<String, dynamic>> selectSpecificFromDatabase(
  //   Database db,
  //   int? id,
  // ) async {
  //   Map<String, dynamic> result = {};
  //   await db.transaction(
  //     (txn) {
  //       return txn
  //           .query("surah",
  //               columns: [
  //                 "id",
  //                 "number",
  //                 "surah_name",
  //                 "surahEnglishName",
  //                 "surahEnglishNameTranslation",
  //                 "numberOfAyahs",
  //                 "revelationType",
  //                 "surah_page",
  //                 "is_favourited",
  //               ],
  //               where: "id = $id")
  //           .then(
  //         (value) {
  //           for (var element in value) {
  //             result = element;
  //             print(result["surah_name"]);
  //             print(result["is_favourited"]);
  //             // allDBSurah!.add(element);
  //           }
  //           emit(RetriveFromDatatBase());
  //         },
  //       ).catchError((error) {
  //         print(error);
  //       });
  //     },
  //   ).catchError(onError);
  //   return result;
  // }

  void changePageViewNaveBar(int index, {bool isClicked = false}) {
    if (isClicked) {
      navBarController.animateToPage(index,
          duration: const Duration(seconds: 1),
          curve: Curves.fastEaseInToSlowEaseOut);
    }
    emit(PageViewChangeState());
    pageNavNumber = index;
  }

  void changeLanguages(String localString) {
    local = Locale(localString);
  }

  Future<void> getFiles() async {
    Directory? externalStorageDirectories = await getExternalStorageDirectory();
    int comIndex = externalStorageDirectories!.absolute.path.indexOf("data");
    String sdCardPath =
        "${externalStorageDirectories.absolute.path.substring(0, comIndex)}test";
    var hiddenFolder = Directory(sdCardPath);
    var files = await hiddenFolder.list().toList();
    // Iterate over the list of files
    for (var file in files) {
      final File filess = File(file.path);
      String text = await filess.path;
      print(text);
    }
  }

  void getFilesOnly() async {
    Directory? externalStorageDirectories = await getExternalStorageDirectory();
    int comIndex = externalStorageDirectories!.absolute.path.indexOf("data");
    String sdCardPath =
        "${externalStorageDirectories.absolute.path.substring(0, comIndex)}media/com.whatsapp/WhatsApp/Media/WhatsApp Images";
    var hiddenFolder = Directory(sdCardPath);
    // Get the application documents directory
    // Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

    // Get a list of all files and directories in the directory
    List<FileSystemEntity> entityList = hiddenFolder.listSync();

    // Filter out the directories
    List<FileSystemEntity> filesOnly =
        entityList.where((entity) => entity is File).toList();

    // Print the file names
    for (var file in filesOnly) {
      print(file.path);
    }
  }

  // Future<void> startDatabase() async {
  //   await openDatabase(
  //     "quranDataBase.db",
  //     onOpen: (db) {
  //       dataBaseQuran = db;
  //       emit(DataBaseOpendState());
  //       print("database Opened");
  //     },
  //   );
  // }

  // Future<void> startDatabaseSearch() async {
  //   await openDatabase(
  //     "quranDataBase.db",
  //     onOpen: (db) {
  //       dataBaseQuran = db;
  //       handleSearch(db,"ا");
  //       emit(DataBaseOpendState());
  //       print("database Opened");
  //     },
  //   );
  // }

  void getAllSurahs() async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    allDBSurah = await dataBaseQuran!.transaction(
      (txn) {
        return txn.query(
          "surah_table",
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
        );
      },
    );
    print(allDBSurah!.length);
    emit(SurahLoadStates());
  }

  void getAllHadeeth() async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    allDBHadeeth = await dataBaseQuran!.transaction(
      (txn) {
        return txn.query(
          "hadeeth_table",
          columns: [
            "id",
            "hadeeth_text",
            "is_favourited",
          ],
        );
      },
    );
    emit(HadeethLoadedState());
  }

  Future<void> makeItFavourit(
      int typeId, String favouriteText, String typeText) async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    await dataBaseQuran!.transaction(
      (txn) {
        return txn.rawInsert(
            "INSERT INTO favourit_table (type_id, favourite_text, type_text) VALUES ($typeId,'$favouriteText','$typeText')");
      },
    ).then(
      (value) {},
    );
  }

  Future<void> deleteFromFavourite(
    int typeId, {
    bool isFromFavouriteScreen = false,
  }) async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    await dataBaseQuran!.transaction(
      (txn) {
        return txn
            .rawDelete("DELETE from favourit_table where type_id = $typeId");
      },
    );
    if (isFromFavouriteScreen) {
      getAllFavourite();
    }
    emit(IsNotFavouriteState());
  }

  void getAllFavourite() async {
    allDBFavourit = [];
    dataBaseQuran = await openDatabase("quranDataBase.db");
    allDBFavourit = await dataBaseQuran!.transaction(
      (txn) {
        return txn.query(
          "favourit_table",
          columns: [
            "id",
            "type_id",
            "favourite_text",
            "type_text",
          ],
        );
      },
    );
    emit(AllFavouritesLoadedState());
  }

  void getAllTasbeeh() async {
    allDBTasbeeh = [];
    dataBaseQuran = await openDatabase("quranDataBase.db");
    allDBTasbeeh = await dataBaseQuran!.transaction(
      (txn) {
        return txn.query(
          "tasbeeh_table",
          columns: [
            "id",
            "tasbeeh_text",
            "total_count",
            "counter",
            "notes",
            "is_favourited",
          ],
        );
      },
    );
    print(allDBTasbeeh!.length);
    emit(AllTasbeehLoadedState());
  }

  void getAllAzkar() async {
    allDBAzkar = [];
    dataBaseQuran = await openDatabase("quranDataBase.db");
    allDBAzkar = await dataBaseQuran!.transaction(
      (txn) {
        return txn.query(
          "azkar_table",
          columns: [
            "id",
            "azkar_title",
            "azkar_text",
            "total_count",
            "counter",
            "notes",
            "is_favourited",
          ],
        );
      },
    );
    emit(AllAzkarLoadedState());
  }

  Future<void> handleSearch(String searchItem) async {
    searchResult = [];
    dataBaseQuran = await openDatabase("quranDataBase.db");
    await dataBaseQuran!.transaction(
      (txn) {
        return txn.query(
          "ayah_table",
          columns: [
            "id",
            "number",
            "numberInSurah",
            "juz",
            "manzil",
            "page",
            "ruku",
            "hizbQuarter",
            "surahNumber",
            "textAyah",
            "is_favourited",
          ],
        ).then(
          (value) {
            searchResult = value;
            print(searchResult!.length);
            print("hello");
          },
        ).catchError((error) {
          print(error);
        });
      },
    ).catchError((error) {
      print(error.toString());
    });
    emit(SearchState());
  }

  void getFavourites(Database db) async {
    allDBSurah = [];
    await db.transaction(
      (txn) {
        return txn.query(
          "favourit_table",
          columns: [
            "id",
            "type_id",
            "favourite_text",
            "type_text",
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

  void setSurahFavourite({
    String? is_favourited,
    int? id,
  }) async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    await dataBaseQuran!.rawUpdate(
        'UPDATE surah_table SET is_favourited = ? WHERE id = ?',
        [is_favourited, '$id']).then((value) {
      getAllSurahs();
      emit(SetFavouriteSurahState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void setHadeethFavourite({
    String? is_favourited,
    int? id,
  }) async {
    dataBaseQuran = await openDatabase("quranDataBase.db");
    await dataBaseQuran!.rawUpdate(
        'UPDATE hadeeth_table SET is_favourited = ? WHERE id = ?',
        [is_favourited, '$id']).then((value) {
      getAllHadeeth();
      emit(SetFavouriteHadeethState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  bool setValue(bool isSelected) {
    return !isSelected;
  }

  void changeDarkOrLightMode() {
    if (AppSharedPrefrence.get("themeMode") == "light") {
      AppSharedPrefrence.setString("themeMode", "dark");
    } else if (AppSharedPrefrence.get("themeMode") == "dark") {
      AppSharedPrefrence.setString("themeMode", "light");
    }
    print(AppSharedPrefrence.get("themeMode"));
    emit(ChangeSwitchState());
  }

  Future<void> getAyahs(
    int page,
    int surahNumber,
  ) async {
    allAyahPage = [];
    dataBaseQuran = await openDatabase("quranDataBase.db");
    allAyahPage = await dataBaseQuran!.rawQuery(
      "SELECT * FROM ayah_table WHERE page = ? AND surahNumber = ?",
      [page, surahNumber],
    );
    emit(LoadAllAyahsState());
  }

  Future<void> getSizeOfPageView(
    int surahNumber,
  ) async {
    allAyahPage = [];
    dataBaseQuran = await openDatabase("quranDataBase.db");
    allAyahPage = await dataBaseQuran!.rawQuery(
      "SELECT page FROM ayah_table WHERE surahNumber = ?",
      [
        surahNumber,
      ],
    );
    print("surah $surahNumber");
    print("surah ${allAyahPage!.length}");
    print(
        "last page ${allAyahPage!.last["page"]} first page ${allAyahPage!.first["page"]}");
    pageViewSize = int.parse(allAyahPage!.last["page"]) -
        int.parse(allAyahPage!.first["page"]);
    emit(PageViewSizeChanged());
  }

  // Future<int> getSizeOfPageView(int surahNumber) async
  // {
  //   int lastPage=0,firstPage=0;
  //   List
  //   dataBaseQuran = await openDatabase("quranDataBase.db");
  //   await dataBaseQuran!.rawQuery(
  //     "SELECT page FROM ayah_table WHERE surahNumber = ? ORDER BY id ASC LIMIT 1",
  //     [
  //       surahNumber,
  //     ],
  //   );
  //   return lastPage-firstPage;
  // }
  Future<void> getFiles2() async {
    loading = true;
    PermissionStatus status = await Permission.manageExternalStorage.request();
    if (status.isGranted == false) {}
    if (await directory.exists() == false) {
      return;
    }
    files = directory.listSync();
    print("${files.length}");
    loading = false;
    emit(FilesLoadedSuccessfull(files: files));
  }

  void sortFileSystemItems() {
    if (sortOrder == SortOrder.ascending) {
      files.sort((a, b) {
        return a.path.compareTo(b.path);
      });
    } else {
      files.sort((a, b) {
        return b.path.compareTo(a.path);
      });
    }
  }
}
