import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/core/functions/navigate.dart';
import 'package:moshafy/modules/loading_screen/cubit/loading_cubit.dart';
import 'package:moshafy/modules/loading_screen/cubit/loading_states.dart';

import '../../../core/routes/app_routes.dart';
import '../../home_page_screen/data/repository/local_repository.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LoadingCubit loadingCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingCubit = LoadingCubit(LocalRepository());
    loadingCubit.setUpDataBase();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);

    return BlocProvider(
      create: (context) => loadingCubit,
      child: BlocConsumer<LoadingCubit, LoadingState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoadingInitialState) {
            loadingCubit.insertSurahToDB();
          }
          else if (state is SurahDataLoadedSuccessfully) {
            loadingCubit.insertAyahToDB();
          } else if (state is AyahDataLoadedSuccessfully) {
            loadingCubit.insertHadeethToDB();
          } else if (state is HadeethDataLoadedSuccessfully) {
            navigate(context: context, route: Routes.homePageScreen);
          }
          print(state);
        },
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
                  if(state is SurahDataLoadedSuccessfully)
                  const Text("تم تحميل السور"),
                  if(state is AyahDataLoadedSuccessfully)
                  const Text("تم تحميل الآيات"),
                  if(state is HadeethDataLoadedSuccessfully)
                  const Text("تم تحميل الأحاديث"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
