import 'package:flutter/material.dart';

import '../../modules/content__screen/screens/content_screen.dart';
import '../../modules/home_page_screen/presentation/screens/home_page.dart';
import '../../modules/loading_screen/screens/loading_screen.dart';
import '../../modules/surah_page__screen/screens/surah_page_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String contentRoute = '/content';
  static const String surahPageView = '/suraPageView';

  static const String homePageScreen = '/homePageScreen';
}

Widget appRoutes(String route, dynamic arg) {
  switch (route) {
    case Routes.initialRoute:
      return const LoadingScreen();
    case Routes.contentRoute:
      return const ContentScreen();
    case Routes.surahPageView:
      return SurahPageScreen();
    case Routes.homePageScreen:
      return const HomePageScreen();

    default:
      return const Scaffold(
        body: Center(
          child: Text('Not Found..!'),
        ),
      );
  }
}
