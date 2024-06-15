import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/modules/content__screen/cubit/content_states.dart';
import '../controls/sura_card.dart';
import '../cubit/conent_cubit.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<ContentPageCubit>(context).
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ContentPageCubit()..startDatabase();
      },
      child: BlocConsumer<ContentPageCubit, ContentStates>(
        builder: (context, state) {
          ContentPageCubit homePageCubit = ContentPageCubit.get(context);
          return Scaffold(
              body: homePageCubit.allDBSurah!.isEmpty
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
                    surah: homePageCubit.allDBSurah![index],
                    onTapFavouriteCard: () {
                      if (homePageCubit.allDBSurah![index]["is_favourited"] ==
                          "true") {
                        homePageCubit.setFavourite(
                            is_favourited: "false",
                            id: homePageCubit.allDBSurah![index]["id"]);
                      } else {
                        homePageCubit.setFavourite(
                            is_favourited: "true",
                            id: homePageCubit.allDBSurah![index]["id"]);
                      }
                      print(
                          homePageCubit.allDBSurah![index]["is_favourited"]);
                    },
                    onTapItemCard: () {
                      // navigate(context: context, route: Routes.surahPageView);
                    },
                  );
                },
                itemCount: homePageCubit.allDBSurah?.length ?? 0,
              )
          );
        },
        listener: (context, state) {
          print(state);
        },
      ),
    );
  }


}
