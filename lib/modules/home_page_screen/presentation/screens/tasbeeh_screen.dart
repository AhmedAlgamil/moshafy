import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshafy/core/functions/navigate.dart';
import 'package:moshafy/core/routes/app_routes.dart';
import 'package:moshafy/modules/home_page_screen/presentation/controls/grid_card_item.dart';

import '../../../../generated/assets.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  late HomePageCubit homePageCubit;

  @override
  void initState() {
    // TODO: implement initState
    homePageCubit = BlocProvider.of<HomePageCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return BlocProvider(
      create: (BuildContext context) {
        return homePageCubit..getAllTasbeeh();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: homePageCubit.allDBTasbeeh!.length,
            itemBuilder: (context, index) {
              return GridCardItem(
                imageName: Assets.imagesTasbehIco,
                itemTitleName: homePageCubit.allDBTasbeeh![index]
                    ["tasbeeh_text"],
                totalCount: homePageCubit.allDBTasbeeh![index]
                ["total_count"],
                counter:  homePageCubit.allDBTasbeeh![index]
                ["counter"],
                onTapAction: () {
                  navigate(context: context, route: Routes.singleSebhaScreen);
                },
              );
            },
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
