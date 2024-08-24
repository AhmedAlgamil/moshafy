import 'dart:io';

import 'package:flutter/material.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class SurahLoadStates extends AppStates {}

class PageViewChangeState extends AppStates {}

class ContentPageStateOpend extends AppStates {}

class HadeethPageStateOpend extends AppStates {}

class FavouritePageStateOpend extends AppStates {}

class QiblaPageStateOpend extends AppStates {}

class SettingsPageStateOpend extends AppStates {}

class LoadAllAyahsState extends AppStates {}
class AllTasbeehLoadedState extends AppStates {}
class AllAzkarLoadedState extends AppStates {}
class FilesLoadedSuccessfull extends AppStates {

  late List<FileSystemEntity> files;

  FilesLoadedSuccessfull({required this.files});
}

class PageViewSizeChanged extends AppStates {}

class SearchState extends AppStates {}

class LoadPageAyahsState extends AppStates {}

class DataBaseLoadedState extends AppStates {}

class HadeethLoadedState extends AppStates {}

class AllFavouritesLoadedState extends AppStates {}

class SetFavouriteState extends AppStates {}

class RetriveFromDatatBase extends AppStates {}

class AppLifeCycleStateChange extends AppStates {}

class DataBaseOpendState extends AppStates {}

class SetFavouriteSurahState extends AppStates {}

class SetFavouriteHadeethState extends AppStates {}

class ChangeSwitchState extends AppStates {
  ChangeSwitchState();
}

class IsNotFavouriteState extends AppStates {}
