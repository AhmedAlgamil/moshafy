import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/generated/assets.dart';
import 'package:moshafy/modules/home_page_screen/presentation/controls/single_page.dart';
import 'package:moshafy/modules/home_page_screen/presentation/cubit/home_page_states.dart';

import '../cubit/home_page_cubit.dart';

class SurahPageScreen extends StatefulWidget {
  const SurahPageScreen({super.key, required this.arguments});

  final dynamic arguments;

  @override
  State<SurahPageScreen> createState() => _SurahPageScreenState();
}

class _SurahPageScreenState extends State<SurahPageScreen> {
  int firstPageIndex = 0, previousPage = 0, myPageIndex = 0;
  late HomePageCubit homePageCubit;

  @override
  void initState() {
    // TODO: implement initState
    homePageCubit = BlocProvider.of<HomePageCubit>(context);
    firstPageIndex = widget.arguments['firstPage'];
    // homePageCubit.getAyahs(firstPageIndex, widget.arguments['surahNumber']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);

    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: homePageCubit.pageController,
              onPageChanged: (int value) {
                myPageIndex = value;
                if (value != previousPage) {
                  if (value > previousPage) {
                    ++firstPageIndex;
                  } else {
                    --firstPageIndex;
                  }
                  previousPage = value;
                }
              },
              // children: List.generate(
              //     widget.arguments['pageViewSize'] == 0
              //         ? 1
              //         : widget.arguments['pageViewSize'], (int index) {
              //   return SinglePage(
              //     homePageCubit: homePageCubit,
              //     firstIndex: firstPageIndex,
              //     surahNumber: widget.arguments['surahNumber'],
              //   );
              // }).toList(),
              children: [
                Image(image: AssetImage(Assets.imagesPage1),height: 20.h,),
                const Image(image: AssetImage(Assets.imagesPage2),),
                const Image(image: AssetImage(Assets.imagesPage3),),
                const Image(image: AssetImage(Assets.imagesPage4),),
                const Image(image: AssetImage(Assets.imagesPage5),),
                const Image(image: AssetImage(Assets.imagesPage6),),
                const Image(image: AssetImage(Assets.imagesPage7),),
                const Image(image: AssetImage(Assets.imagesPage2),),
                if(false)
                SinglePage(
                  homePageCubit: homePageCubit,
                  surahNumber: 2,
                  firstIndex: 2,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {},
                  color: th.primaryColorLight,
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_left_outlined),
                      Text(
                        "السورة السابقة",
                      ),
                    ],
                  ),
                ),
                Text("$myPageIndex/${widget.arguments['pageViewSize']}"),
                MaterialButton(
                  onPressed: () {},
                  color: th.primaryColorLight,
                  child: const Row(
                    children: [
                      Text(
                        "السورة التالية",
                      ),
                      Icon(Icons.arrow_right_outlined),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // body: Container(),
    );
  }
}
