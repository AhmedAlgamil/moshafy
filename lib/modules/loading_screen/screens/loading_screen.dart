import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/app_routes.dart';
import '../../home_page_screen/presentation/cubit/home_page_cubit.dart';
import '../../home_page_screen/presentation/cubit/home_page_states.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return BlocProvider(
      create: (BuildContext context) {
        return HomePageCubit()..setupDB();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("تحميل جميع السور والايات والاحاديث",
                      style: th.textTheme.titleLarge),
                  Text("دقيقة من فضلك الصبر مفتاح الفرج",
                      style: th.textTheme.titleMedium),
                  Text("من فضلك لا تقم بغلق التطبيق عند التحميل",
                      style: th.textTheme.titleMedium),
                  Center(
                    child: SizedBox(
                      width: 300.w,
                      child: const LinearProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is DataInsertedState) {
            Navigator.of(context).pushReplacementNamed(Routes.homePageScreen);
          }
        },
      ),
    );
  }
}
