import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/core/util/app_colors.dart';
import 'package:moshafy/modules/home_page_screen/presentation/cubit/home_page_states.dart';
import '../../../../generated/assets.dart';
import '../cubit/home_page_cubit.dart';
import '../controls/search_item_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // searchCubit = HomePageCubit.get(context);
    // searchCubit.startDatabase();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return BlocProvider(
      create: (context) {
        return HomePageCubit();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          HomePageCubit searchCubit = HomePageCubit.get(context);
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  opacity: 0.4,
                  image: AssetImage(Assets.imagesLightBack),
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 50.0.h, left: 20.0.w, right: 20.0.w),
                child: Column(
                  children: [
                    TextFormField(
                      textDirection: TextDirection.rtl,
                      onChanged: (value) {
                        searchCubit.handleSearch(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.kPrimaryColor,
                            width: 2.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.kPrimaryColor,
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.sp,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.sp,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0.h),
                      child: ToggleButtons(
                        selectedColor: th.primaryColorLight,
                        borderRadius: BorderRadius.circular(15.sp),
                        color: th.primaryColorDark,
                        fillColor: th.primaryColorDark,
                        onPressed: (index) {
                          searchCubit.items[index] =
                              searchCubit.setValue(searchCubit.items[index]);
                        },
                        isSelected: searchCubit.items,
                        textStyle: TextStyle(
                          fontSize: th.textTheme.titleMedium?.fontSize,
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0.h,
                                left: 20.0.w,
                                right: 20.0.w,
                                bottom: 10.h),
                            child: const Text(
                              "مصحف",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0.h,
                                left: 20.0.w,
                                right: 20.0.w,
                                bottom: 10.h),
                            child: const Text(
                              "حديث",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0.h,
                                left: 20.0.w,
                                right: 20.0.w,
                                bottom: 10.h),
                            child: const Text(
                              "آية",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return SearchCardItem(
                            text:
                                "وَٱلَّذِينَ يُؤْمِنُونَ بِمَآ أُنزِلَ إِلَيْكَ وَمَآ أُنزِلَ مِن قَبْلِكَ وَبِٱلْءَاخِرَةِ هُمْ يُوقِنُونَ وَٱلَّذِينَ يُؤْمِنُونَ بِمَآ أُنزِلَ إِلَيْكَ وَمَآ أُنزِلَ مِن قَبْلِكَ وَبِٱلْءَاخِرَةِ هُمْ يُوقِنُونَ وَٱلَّذِينَ يُؤْمِنُونَ بِمَآ أُنزِلَ إِلَيْكَ وَمَآ أُنزِلَ مِن قَبْلِكَ وَبِٱلْءَاخِرَةِ هُمْ يُوقِنُونَ",
                            id: "1",
                          );
                        },
                        itemCount: 5,
                        padding: EdgeInsets.only(top: 10.h),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          print(state);
        },
      ),
    );
  }
}
