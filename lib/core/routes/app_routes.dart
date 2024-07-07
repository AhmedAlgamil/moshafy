import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshafy/modules/home_page_screen/presentation/cubit/home_page_cubit.dart';
import '../../modules/home_page_screen/presentation/screens/content_screen.dart';
import '../../modules/home_page_screen/presentation/screens/home_page.dart';
import '../../modules/loading_screen/screens/loading_screen.dart';
import '../../modules/home_page_screen/presentation/screens/search_screen.dart';
import '../../modules/home_page_screen/presentation/screens/surah_page_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String contentRoute = '/content';
  static const String surahPageView = '/suraPageView';

  static const String homePageScreen = '/homePageScreen';
  static const String seearchScreen = '/seearchScreen';
}

Widget appRoutes(String route, dynamic arg) {
  switch (route) {
    case Routes.initialRoute:
      return const LoadingScreen();
    case Routes.contentRoute:
      return ContentScreen();
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
