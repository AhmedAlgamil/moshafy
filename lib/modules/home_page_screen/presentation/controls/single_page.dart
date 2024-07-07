import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moshafy/modules/home_page_screen/presentation/cubit/home_page_cubit.dart';
import 'package:moshafy/modules/home_page_screen/presentation/cubit/home_page_states.dart';

class SinglePage extends StatefulWidget {
  SinglePage({
    super.key,
    required this.homePageCubit,
    required this.surahNumber,
    required this.firstIndex,
  });

  int firstIndex, surahNumber;
  late HomePageCubit homePageCubit;

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  @override
  void initState() {
    // TODO: implement initState
    widget.homePageCubit.getAyahs(widget.firstIndex, widget.surahNumber);
    print(widget.homePageCubit.allAyahPage!.length);
    print(widget.firstIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            RichText(
              maxLines: 20,
              textDirection: TextDirection.rtl,
              text: TextSpan(
                style: th.textTheme.bodyMedium,
                children: List.generate(
                  widget.homePageCubit.allAyahPage!.length,
                  (ayahIndex) {
                    return TextSpan(
                      text:
                          "${widget.homePageCubit.allAyahPage![ayahIndex]['textAyah']}"
                          " ﴿${widget.homePageCubit.allAyahPage![ayahIndex]['numberInSurah']}﴾",
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
