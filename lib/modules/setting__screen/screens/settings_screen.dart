import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/app_colors.dart';
import '../../home_page_screen/presentation/cubit/home_page_cubit.dart';
import '../../home_page_screen/presentation/cubit/home_page_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: Card(
                  elevation: 10.0.sp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.sp,
                      ),
                    ),
                  ),
                  child: ListTile(
                    selected: true,
                    onTap: () {},
                    title: Text(
                      "اللغة",
                    ),
                    trailing: Text(
                      "العربية",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: Card(
                  elevation: 10.0.sp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.sp,
                      ),
                    ),
                  ),
                  child: ListTile(
                    selected: true,
                    onTap: () {},
                    title: Text(
                      "الوضع اليلي",
                    ),
                    trailing: Switch(
                      onChanged: (value) {
                        if (value) {
                        } else {}
                      },
                      value: true,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Divider(color: AppColors.kPrimaryColor,thickness: 20.h),
                  Divider(color: AppColors.kPrimaryColor,thickness: 20.h),
                  Divider(color: AppColors.kPrimaryColor,thickness: 20.h),
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
