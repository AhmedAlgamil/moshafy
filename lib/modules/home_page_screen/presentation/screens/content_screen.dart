import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/modules/home_page_screen/presentation/cubit/home_page_cubit.dart';

import '../../../../core/functions/navigate.dart';
import '../../../../core/routes/app_routes.dart';
import '../controls/sura_card.dart';
import '../cubit/home_page_states.dart';

class ContentScreen extends StatefulWidget {
  ContentScreen({
    super.key,
  });

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late HomePageCubit contentPageCubit;

  late List<Map<String, dynamic>>? allDBSurah;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contentPageCubit = BlocProvider.of<HomePageCubit>(context);
    contentPageCubit.getAllSurahs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocConsumer<HomePageCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
          print(state);
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: contentPageCubit.allDBSurah!.isEmpty
                ? Center(
                    child: SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return SurahItemCard(
                        surah: contentPageCubit.allDBSurah![index],
                        onTapFavouriteCard: () {
                          if (contentPageCubit.allDBSurah![index]
                                  ["is_favourited"] ==
                              "true") {
                            contentPageCubit.setSurahFavourite(
                                is_favourited: "false",
                                id: contentPageCubit.allDBSurah![index]["id"]);
                            contentPageCubit.deleteFromFavourite(
                              contentPageCubit.allDBSurah![index]["id"],
                            );
                          } else {
                            contentPageCubit.setSurahFavourite(
                                is_favourited: "true",
                                id: contentPageCubit.allDBSurah![index]["id"]);
                            contentPageCubit.makeItFavourit(
                              contentPageCubit.allDBSurah![index]["id"],
                              contentPageCubit.allDBSurah![index]["surah_name"],
                              "مصحف",
                            );
                          }
                        },
                        onTapItemCard: () {
                          // BlocProvider.of<HomePageCubit>(context).emit();
                          contentPageCubit
                              .getSizeOfPageView(
                            int.parse(
                              contentPageCubit.allDBSurah![index]['number'],
                            ),
                          )
                              .then(
                            (value) {
                              Map<String, dynamic> args = {
                                'pageViewSize': contentPageCubit.pageViewSize!,
                                'firstPage': int.parse(
                                  contentPageCubit.allAyahPage!.first['page'],

                                ),
                                'lastPage': int.parse(
                                  contentPageCubit.allAyahPage!.last['page'],
                                ),
                                'surahNumber': int.parse(
                                  contentPageCubit.allDBSurah![index]['number'],
                                ),
                              };
                              navigate(
                                context: context,
                                route: Routes.surahPageView,
                                arg: args,
                              );
                            },
                          );
                        },
                      );
                    },
                    itemCount: contentPageCubit.allDBSurah?.length,
                  ),
          );
        },
      ),
    );
  }
}
