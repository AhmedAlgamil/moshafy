import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/modules/qibla__screen/screens/qibla_screen.dart';
import 'package:moshafy/modules/setting__screen/screens/settings_screen.dart';
import '../../../../core/util/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../content__screen/screens/content_screen.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';
import '../../../favourite__screen/screens/favourite_screen.dart';
import '../../../hadeeth__screen/screens/hadeeth_screen.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return BlocProvider(
      create: (BuildContext context) {
        return HomePageCubit();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);
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
                              onPressed: () {},
                              height: 40.h,
                              minWidth: 50.w,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.sp)
                              ),
                              elevation: 10,
                              child: const Icon(Icons.search,size: 20),
                            ),
                            Text(
                              homePageCubit.titles[homePageCubit.pageNavNumber],
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
                        children: const [
                          ContentScreen(),
                          HadeethScreen(),
                          FavouriteScreen(),
                          QiblaScreen(),
                          SettingsScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar:BottomNavigationBar(
              onTap: (val){
                homePageCubit.changePageViewNaveBar(val,isClicked: true);
              },
              unselectedItemColor: Colors.white,
              selectedFontSize: 20.sp,
              currentIndex: homePageCubit.pageNavNumber,
              backgroundColor: AppColors.kPrimaryColor,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              selectedIconTheme: const IconThemeData(color: Colors.amber),
              useLegacyColorScheme: true,
              items: [
                BottomNavigationBarItem(icon: Image.asset(Assets.imagesQuranNavbar,width: 30.w,height: 30.h,color: homePageCubit.pageNavNumber == 0 ? Colors.amber :Colors.white),label: homePageCubit.titles[0]),
                BottomNavigationBarItem(icon: Image.asset(Assets.imagesIslam,width: 30.w,height: 30.h,color: homePageCubit.pageNavNumber == 1 ? Colors.amber :Colors.white),label: homePageCubit.titles[1]),
                BottomNavigationBarItem(icon: Image.asset(Assets.imagesStar,width: 30.w,height: 30.h,color: homePageCubit.pageNavNumber == 2 ? Colors.amber :Colors.white),label: homePageCubit.titles[2]),
                BottomNavigationBarItem(icon: Image.asset(Assets.imagesQibla,width: 30.w,height: 30.h,color: homePageCubit.pageNavNumber == 3 ? Colors.amber :Colors.white),label: homePageCubit.titles[3]),
                BottomNavigationBarItem(icon: Image.asset(Assets.imagesSettings,width: 30.w,height: 30.h,color: homePageCubit.pageNavNumber == 4 ? Colors.amber :Colors.white),label: homePageCubit.titles[4]),
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
