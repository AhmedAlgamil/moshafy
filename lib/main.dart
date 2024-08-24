import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constatnts/constants.dart';
import 'core/local/shared_prefrence.dart';
import 'core/routes/app_routes.dart';
import 'core/util/themes.dart';
import 'generated/l10n.dart';
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
      BlocProvider<HomePageCubit>(
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageCubit = BlocProvider.of<HomePageCubit>(context);
    homePageCubit.changeDarkOrLightMode();
    HomePageCubit.get(context).emit(ChangeSwitchState());
    // homePageCubit.changeDarkOrLightMode();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          title: 'Quran Karem',
          theme: AppThemes.lightMode,
          darkTheme: AppThemes.darkMode,
          locale: const Locale('ar'),
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Spanish
          ],
          localizationsDelegates: const [
            AppLocalizationDelegate(),
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          // themeMode: HomePageCubit.get(context).themeMode,
          // themeMode: AppSharedPrefrence.get("themeMod").toString() == "Device"
          //     ? ThemeMode.system
          //     : AppSharedPrefrence.get("themeMod").toString() == "light"
          //         ? ThemeMode.light
          //         : ThemeMode.dark,
          // initialRoute: AppSharedPrefrence.get(Constants.DATAINSERTED) != null ? Routes.homePageScreen : Routes.initialRoute,
          home: AppSharedPrefrence.get(Constants.DATAINSERTED) != null
              ? const Directionality(
                  textDirection: TextDirection.ltr,
                  child: HomePageScreen(
                    argument: "hello",
                  ))
              : const LoadingScreen(),
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) =>
                  appRoutes(settings.name!, settings.arguments),
            );
          },
        );
      },
    );
  }
}
