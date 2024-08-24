import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotreloader/hotreloader.dart';
import 'core/constatnts/constants.dart';
import 'core/local/shared_prefrence.dart';
import 'core/routes/app_routes.dart';
import 'core/util/themes.dart';
import 'generated/l10n.dart';
import 'package:provider/provider.dart';
import 'modules/home_page_screen/presentation/cubit/home_page_cubit.dart';
import 'modules/home_page_screen/presentation/cubit/home_page_states.dart';
import 'modules/home_page_screen/presentation/screens/home_page.dart';
import 'modules/loading_screen/screens/loading_screen.dart';

Future<void> main() async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPrefrence.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (BuildContext context) => HomePageCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late HomePageCubit homePageCubit;
  late ThemeMode themeMode;

  @override
  void initState() {
    // TODO: implement initState
    homePageCubit = BlocProvider.of<HomePageCubit>(context);
    AppSharedPrefrence.setString("themeMode", "light");
    super.initState();
    // homePageCubit.changeDarkOrLightMode();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: HomePageCubit(),child: ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          theme: AppThemes.lightMode,
          darkTheme: AppThemes.darkMode,
          supportedLocales: S.delegate.supportedLocales,
          locale: S.delegate.supportedLocales[1],
          localizationsDelegates: const [
            AppLocalizationDelegate(),
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          themeMode: AppSharedPrefrence.get("themeMode") == "light"
              ? ThemeMode.light
              : ThemeMode.dark,
          // themeMode: HomePageCubit.get(context).themeMode,
          // themeMode: AppSharedPrefrence.get("themeMod").toString() == "Device"
          //     ? ThemeMode.system
          //     : AppSharedPrefrence.get("themeMod").toString() == "light"
          //         ? ThemeMode.light
          //         : ThemeMode.dark,
          // initialRoute: AppSharedPrefrence.get(Constants.DATAINSERTED) != null ? Routes.homePageScreen : Routes.initialRoute,
          initialRoute:
          AppSharedPrefrence.get(Constants.DATAINSERTED) != null
              ? Routes.homePageScreen
              : Routes.initialRoute,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) =>
                  appRoutes(settings.name!, settings.arguments),
            );
          },
        );
      },
    ),);
  }
}
