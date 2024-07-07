import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/navigate.dart';
import '../../../../core/routes/app_routes.dart';
import '../controls/hadeeth_card.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';

class HadeethScreen extends StatefulWidget {
  HadeethScreen({super.key});

  @override
  State<HadeethScreen> createState() => _HadeethScreenState();
}

class _HadeethScreenState extends State<HadeethScreen> {
  late HomePageCubit hadeethPageCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hadeethPageCubit = BlocProvider.of<HomePageCubit>(context);
    hadeethPageCubit.getAllHadeeth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return HadeethItemCard(
            hadeethText: hadeethPageCubit.allDBHadeeth![index]['hadeeth_text'],
            iconButtonAction: () {
              if (hadeethPageCubit.allDBHadeeth![index]["is_favourited"] ==
                  "true") {
                hadeethPageCubit.setHadeethFavourite(
                    is_favourited: "false",
                    id: hadeethPageCubit.allDBHadeeth![index]["id"]);
                hadeethPageCubit.deleteFromFavourite(
                  hadeethPageCubit.allDBHadeeth![index]["id"],
                );
              } else {
                hadeethPageCubit.setHadeethFavourite(
                    is_favourited: "true",
                    id: hadeethPageCubit.allDBHadeeth![index]["id"]);
                hadeethPageCubit.makeItFavourit(
                  hadeethPageCubit.allDBHadeeth![index]["id"],
                  hadeethPageCubit.allDBHadeeth![index]["hadeeth_text"],
                  "حديث",
                );
              }
            },
            isFavaouraited: bool.parse(
              hadeethPageCubit.allDBHadeeth![index]['is_favourited'],
            ),
            onTapItemCard: () {
              navigate(context: context, route: Routes.surahPageView);
            },
          );
        },
        itemCount: hadeethPageCubit.allDBHadeeth!.length,
      ),
    );
  }
}
