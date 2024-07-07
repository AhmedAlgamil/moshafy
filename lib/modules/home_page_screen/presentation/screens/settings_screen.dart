import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/app_colors.dart';
import '../controls/switch_setting_card.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';
import '../controls/setting_card.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
              const SettingCard(
                trailingText: "العربية",
                leadingText: "اللغة",
              ),
              SwitchSettingCard(
                switchValue: homePageCubit.switchValue,
                onTapItemCard: () {
                  homePageCubit.changeDarkOrLightMode();
                  HomePageCubit.get(context).emit(ChangeSwitchState());
                },
              ),
              Row(
                children: [
                  Divider(color: AppColors.kPrimaryColor, thickness: 20.h),
                  Divider(color: AppColors.kPrimaryColor, thickness: 20.h),
                  Divider(color: AppColors.kPrimaryColor, thickness: 20.h),
                ],
              ),
            ],
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
