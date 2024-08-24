import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/core/functions/navigate.dart';
import 'package:moshafy/core/routes/app_routes.dart';
import 'package:moshafy/modules/home_page_screen/presentation/controls/grid_card_item.dart';

import '../../../../core/util/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../controls/switch_setting_card.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';
import '../controls/setting_card.dart';
class MoreSettingsScreen extends StatefulWidget {
  const MoreSettingsScreen({super.key});

  @override
  State<MoreSettingsScreen> createState() => _MoreSettingsScreenState();
}

class _MoreSettingsScreenState extends State<MoreSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    S lang = S.of(context);
    return BlocProvider(
      create: (BuildContext context) {
        // return HomePageCubit()..getSurahs();
        return HomePageCubit();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);
          return GridView.count(crossAxisCount: 2,children: [
            GridCardItem(
              imageName: Assets.imagesTasbehIco,
              itemTitleName: lang.tasbeeh,
              onTapAction: () {
              },
            ),GridCardItem(
              imageName: Assets.imagesQiblaIco,
              itemTitleName: lang.qibla,
              onTapAction: () {
                navigate(context: context, route: Routes.qiblaScreen);
              },
            ),GridCardItem(
              imageName: Assets.imagesAzkarIco,
              itemTitleName: lang.azkar,
            ),
          ],);
        },
        listener: (context, state) {},
      ),
    );
  }
}
