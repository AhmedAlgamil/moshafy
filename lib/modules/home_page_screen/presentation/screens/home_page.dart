import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/modules/home_page_screen/presentation/screens/qibla_screen.dart';
import 'package:moshafy/modules/home_page_screen/presentation/screens/more_settings_screen.dart';
import 'package:moshafy/modules/home_page_screen/presentation/screens/tasbeeh_screen.dart';

import '../../../../core/functions/navigate.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/util/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import 'content_screen.dart';
import 'favourite_screen.dart';
import 'hadeeth_screen.dart';
import 'settings_screen.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key, this.argument});

  final dynamic argument;

  @override
  Widget build(BuildContext context) {
    print(argument);
    ThemeData th = Theme.of(context);
    List<String> titles = [
      S.of(context).moshaf,
      S.of(context).hadeeth,
      S.of(context).favourit,
      S.of(context).tasbeeh,
      S.of(context).settings,
    ];
    return BlocProvider(
      create: (BuildContext context) {
        return HomePageCubit();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        buildWhen: (previous, current) {
          print(current);
          return true;
        },
        builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);
          ThemeData th = Theme.of(context);
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  opacity: 0.4,
                  image: AssetImage(Assets.imagesLightBack),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: Column(
                  children: [
                    Align(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 10.h, right: 15.w, left: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                navigate(
                                  context: context,
                                  route: Routes.test,
                                );
                              },
                              height: 40.h,
                              minWidth: 50.w,
                              color: th.primaryColorDark,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.sp)),
                              elevation: 10,
                              child: Icon(
                                Icons.search,
                                size: 23.sp,
                                color: th.primaryColorLight,
                              ),
                            ),
                            Text(
                              titles[homePageCubit.pageNavNumber],
                              style: th.textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (value) {
                          homePageCubit.changePageViewNaveBar(value);
                        },
                        controller: homePageCubit.navBarController,
                        children: [
                          ContentScreen(),
                          HadeethScreen(),
                          FavouriteScreen(),
                          BlocProvider(
                            create: (context) => HomePageCubit(),
                            child: const TasbeehScreen(),
                          ),
                          const MoreSettingsScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (val) {
                homePageCubit.changePageViewNaveBar(val, isClicked: true);
              },
              unselectedItemColor: Colors.white,
              selectedFontSize: th.textTheme.titleMedium!.fontSize!,
              currentIndex: homePageCubit.pageNavNumber,
              backgroundColor: AppColors.kPrimaryColor,
              unselectedFontSize: th.textTheme.titleMedium!.fontSize!,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              selectedIconTheme: const IconThemeData(color: Colors.amber),
              useLegacyColorScheme: true,
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      Assets.imagesQuranNavbar,
                      width: 30.w,
                      height: 30.h,
                      color: homePageCubit.pageNavNumber == 0
                          ? Colors.amber
                          : Colors.white,
                    ),
                    label: titles[0]),
                BottomNavigationBarItem(
                    icon: Image.asset(Assets.imagesIslam,
                        width: 30.w,
                        height: 30.h,
                        color: homePageCubit.pageNavNumber == 1
                            ? Colors.amber
                            : Colors.white),
                    label: titles[1]),
                BottomNavigationBarItem(
                    icon: Image.asset(Assets.imagesStar,
                        width: 30.w,
                        height: 30.h,
                        color: homePageCubit.pageNavNumber == 2
                            ? Colors.amber
                            : Colors.white),
                    label: titles[2]),
                BottomNavigationBarItem(
                  icon: Image.asset(Assets.imagesTasbehIco,
                      width: 40.w,
                      height: 40.h,
                      color: homePageCubit.pageNavNumber == 3
                          ? Colors.amber
                          : Colors.white),
                  label: titles[3],
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Assets.imagesMore,
                    width: 30.w,
                    height: 30.h,
                    color: homePageCubit.pageNavNumber == 4
                        ? Colors.amber
                        : Colors.white,
                  ),
                  label: titles[4],
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          print("listener $state");
        },
      ),
    );
  }
}
