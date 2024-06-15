import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/assets.dart';
import '../../home_page_screen/presentation/controls/hadeeth_card.dart';
import '../../home_page_screen/presentation/cubit/home_page_cubit.dart';
import '../../home_page_screen/presentation/cubit/home_page_states.dart';

class QiblaScreen extends StatelessWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return HomePageCubit();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  Assets.imagesQiblaLogo,
                ),
              ),
            ],
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
