import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/core/functions/navigate.dart';
import 'package:moshafy/core/routes/app_routes.dart';
import 'package:moshafy/modules/home_page_screen/presentation/controls/grid_card_item.dart';

import '../../../../core/util/app_colors.dart';
import '../../../../generated/assets.dart';
import '../controls/switch_setting_card.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';
import '../controls/setting_card.dart';

class SingleSebhaScreen extends StatefulWidget {
  const SingleSebhaScreen({
    super.key,
    this.singleSebha,
  });

  final dynamic singleSebha;

  @override
  State<SingleSebhaScreen> createState() => _SingleSebhaScreenState();
}

class _SingleSebhaScreenState extends State<SingleSebhaScreen> {
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
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.4,
                image: AssetImage(Assets.imagesLightBack),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
