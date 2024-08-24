import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshafy/modules/home_page_screen/presentation/cubit/home_page_cubit.dart';
import 'package:moshafy/modules/home_page_screen/presentation/screens/qibla_screen.dart';
import 'package:moshafy/modules/home_page_screen/presentation/screens/test_screen.dart';
import '../../modules/home_page_screen/presentation/screens/content_screen.dart';
import '../../modules/home_page_screen/presentation/screens/home_page.dart';
import '../../modules/home_page_screen/presentation/screens/single_sebha_screen.dart';
import '../../modules/home_page_screen/presentation/screens/tasbeeh_screen.dart';
import '../../modules/loading_screen/screens/loading_screen.dart';
import '../../modules/home_page_screen/presentation/screens/search_screen.dart';
import '../../modules/home_page_screen/presentation/screens/surah_page_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String contentRoute = '/content';
  static const String surahPageView = '/suraPageView';

  static const String homePageScreen = '/homePageScreen';
  static const String seearchScreen = '/seearchScreen';
  static const String qiblaScreen = '/qiblaScreen';
  static const String tasbeehScreen = '/tasbeehScreen';

  static const String singleSebhaScreen = '/singleSebhaScreen';
  static const String test = '/test';
}

Widget appRoutes(String route, dynamic arg) {
  switch (route) {
    case Routes.initialRoute:
      return const LoadingScreen();
    case Routes.contentRoute:
      return ContentScreen();
      case Routes.qiblaScreen:
      return const QiblaScreen();
      case Routes.tasbeehScreen:
      return const TasbeehScreen();
      case Routes.test:
      return const TestScreen();
      case Routes.singleSebhaScreen:
      return SingleSebhaScreen(singleSebha: arg,);
    case Routes.surahPageView:
      return BlocProvider(
        create: (context) => HomePageCubit(),
        child: SurahPageScreen(
          arguments: arg,
        ),
      );
    case Routes.homePageScreen:
      return Directionality(
        textDirection: TextDirection.ltr,
        child: HomePageScreen(
          argument: arg,
        ),
      );
    case Routes.seearchScreen:
      return const SearchScreen();

    default:
      return const Scaffold(
        body: Center(
          child: Text('Not Found..!'),
        ),
      );
  }
}
