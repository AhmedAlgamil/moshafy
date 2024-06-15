import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/navigate.dart';
import '../../../core/routes/app_routes.dart';
import '../../home_page_screen/presentation/controls/hadeeth_card.dart';
import '../../home_page_screen/presentation/cubit/home_page_cubit.dart';
import '../../home_page_screen/presentation/cubit/home_page_states.dart';

class HadeethScreen extends StatelessWidget {
  const HadeethScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        // return HomePageCubit()..getHadeeths();
        return HomePageCubit();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);
          return ListView.builder(
            itemBuilder: (context, index) {
              return HadeethItemCard(
                hadeethText: homePageCubit.allHadeeth[index].text,
                iconButtonAction: (){

                },
                isFavaouraited: true,
                onTapItemCard: () {
                  navigate(context: context, route: Routes.surahPageView);
                },
              );
            },
            itemCount: homePageCubit.allHadeeth.length ?? 0,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
