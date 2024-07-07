import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/navigate.dart';
import '../../../../core/routes/app_routes.dart';
import '../cubit/home_page_cubit.dart';
import '../controls/favourite_card.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late HomePageCubit homePageCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageCubit = BlocProvider.of<HomePageCubit>(context);
    homePageCubit.getAllFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
          itemBuilder: (context, index) {
            return FavouriteItem(
              favouriteModel: homePageCubit.allDBFavourit![index],
              onTapItemCard: () {
                switch (homePageCubit.allDBFavourit![index]['type_text']) {
                  case "مصحف":
                    navigate(context: context, route: Routes.surahPageView);
                    break;
                  case "حديث":
                    navigate(context: context, route: Routes.surahPageView);
                    break;
                  case "":
                    navigate(context: context, route: Routes.surahPageView);
                    break;
                }
              },
            );
          },
          itemCount: homePageCubit.allDBFavourit!.length,
        ));
  }
}
