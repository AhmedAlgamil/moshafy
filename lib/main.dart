import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constatnts/constants.dart';
import 'core/database_heper/database_helper.dart';
import 'core/local/cach_helper.dart';
import 'core/local/shared_prefrence.dart';
import 'core/routes/app_routes.dart';
import 'core/util/themes.dart';
import 'modules/home_page_screen/presentation/screens/home_page.dart';
import 'modules/loading_screen/screens/loading_screen.dart';
import 'modules/home_page_screen/presentation/screens/test_screen.dart';


Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPrefrence.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          themeMode: ThemeMode.light,
          // home: const TestScreen(),
          home: AppSharedPrefrence.get(Constants.DATAINSERTED) != null ? const HomePageScreen() : const LoadingScreen(),
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