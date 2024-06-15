import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return BlocProvider(
      create: (BuildContext context) {
        return HomePageCubit()..setupAppLifyCycle();
      },
      child: BlocConsumer<HomePageCubit, AppStates>(
        builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              actions: [IconButton(icon: Icon(Icons.home), onPressed: () {
                // homePageCubit.
              },)],
              title: const Text('App LifeCycle State'),
            ),
            body: Center(
              child: SizedBox(
                width: 300,
                child: SingleChildScrollView(
                  controller: homePageCubit.scrollController,
                  child: Column(
                    children: <Widget>[
                      Text('Current State: ${homePageCubit.state ?? 'Not initialized yet'}'),
                      const SizedBox(height: 30),
                      Text('State History:\n ${homePageCubit.states.join('\n ${homePageCubit.indexStates} ')}'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
