import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/core/util/utils.dart';
import 'package:moshafy/modules/home_page_screen/presentation/cubit/home_page_cubit.dart';

import '../../../../generated/assets.dart';
import '../cubit/home_page_states.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  late HomePageCubit homePageCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageCubit = HomePageCubit.get(context);
    homePageCubit.setUpCompassMovment();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homePageCubit.setUpCompassMovment(isCompassClosed: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return HomePageCubit();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image: const AssetImage(
                          Assets.imagesQiblaLogo,
                        ),
                        height: 300.h,
                        width: 300.w,
                      ),
                      Transform.rotate(
                        angle: homePageCubit.angle,
                        child: Image(
                          image: const AssetImage(
                            Assets.imagesMoveLogo,
                          ),
                          height: 200.h,
                          width: 200.w,
                        ),
                      ),
                      Image(
                        image: const AssetImage(
                          Assets.imagesQibla,
                        ),
                        height: 70.h,
                        width: 70.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
