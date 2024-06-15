import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_page_screen/presentation/cubit/home_page_cubit.dart';
import '../../home_page_screen/presentation/cubit/home_page_states.dart';

class SurahPageScreen extends StatelessWidget {
  SurahPageScreen({super.key});

  int index = 0;

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return BlocProvider(
      create: (BuildContext context) {
        // return HomePageCubit()..getAyahs();
        return HomePageCubit();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      if (index <= 0) {
                        print(index);
                      } else {
                        index--;
                        homePageCubit.changePageView(index);
                      }
                    },
                    icon: Icon(Icons.arrow_left)),
                IconButton(
                    onPressed: () {
                      if (index >= 2) {
                        print(index);
                      } else {
                        index++;
                        homePageCubit.changePageView(index);
                      }
                    },
                    icon: Icon(Icons.arrow_right)),
              ],
            ),
            body: PageView(
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                homePageCubit.changePageView(value);
              },
              controller: homePageCubit.controller,
              children: List.generate(
                604,
                    (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        RichText(
                          maxLines: 15,
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            style: th.textTheme.bodyLarge,
                            children: List.generate(
                              homePageCubit.allAyahPage!.length,
                                  (ayahIndex) {
                                return TextSpan(
                                  text:
                                  "${homePageCubit.allAyahPage![ayahIndex]
                                      .textAyah} ﴿${homePageCubit
                                      .allAyahPage![ayahIndex]
                                      .numberInSurah}﴾",
                                );
                              },
                            ),),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
        listener: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);
          print(state);
          if (state is LoadAllAyahsState) {
            homePageCubit.getAyahsPage(1);
          }
        },
      ),
    );
  }
}
