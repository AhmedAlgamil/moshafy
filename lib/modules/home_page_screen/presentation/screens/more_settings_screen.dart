import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotreloader/hotreloader.dart';
import 'package:moshafy/core/functions/navigate.dart';
import 'package:moshafy/core/routes/app_routes.dart';
import 'package:moshafy/main.dart';
import 'package:moshafy/modules/home_page_screen/presentation/controls/grid_card_item.dart';

import '../../../../core/local/shared_prefrence.dart';
import '../../../../core/util/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../controls/setting_card_button.dart';
import '../controls/switch_setting_card.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';
import '../controls/about_card_button.dart';

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
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SettingCardButton(
                    imageName: Assets.imagesAzkarIco,
                    itemTitleName: lang.azkar,
                  ),
                  SettingCardButton(
                    imageName: Assets.imagesQiblaIco,
                    itemTitleName: lang.qibla,
                    onTapAction: () {
                      navigate(context: context, route: Routes.qiblaScreen);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SettingCardButton(
                    imageName: Assets.assetsImagesLangauges,
                    itemTitleName: lang.lang,
                    onTapAction: () {},
                  ),
                  SettingCardButton(
                    imageName: Assets.imagesThemes,
                    itemTitleName: AppSharedPrefrence.get("themeMode") == "light"
                        ? lang.light_mode
                        : lang.darkmode ,
                    onTapAction: () async {
                      BlocProvider.of<HomePageCubit>(context).changeDarkOrLightMode();
                    },
                  ),
                ],
              ),
              Image(
                width: 300.w,
                color: th.primaryColorDark,
                image: AssetImage(
                  Assets.imagesAbout,
                ),
              ),
              AboutCardButton(
                leadingText: lang.rate,
                widget: Icon(Icons.star,color: Colors.amber,),
              ),
              AboutCardButton(
                leadingText: lang.about_me,
                widget: Icon(Icons.info_outline,color: th.primaryColorDark,),
              ),
            ],
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
