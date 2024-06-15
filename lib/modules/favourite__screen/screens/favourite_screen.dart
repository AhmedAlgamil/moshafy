import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/navigate.dart';
import '../../../core/routes/app_routes.dart';
import '../controls/favourite_card.dart';
import '../../home_page_screen/presentation/controls/hadeeth_card.dart';
import '../../home_page_screen/presentation/cubit/home_page_cubit.dart';
import '../../home_page_screen/presentation/cubit/home_page_states.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return HomePageCubit();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);
          return ListView.builder(
            itemBuilder: (context, index) {
              return FavouriteItem(
                favouriteModel: homePageCubit.favItems[index],
                iconButtonAction: () {},
                isFavaouraited: true,
                onTapItemCard: () {
                  switch(homePageCubit.favItems[index].favType)
                  {
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
            itemCount: homePageCubit.favItems.length ?? 0,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
