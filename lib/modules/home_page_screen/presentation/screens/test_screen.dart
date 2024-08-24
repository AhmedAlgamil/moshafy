import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moshafy/core/routes/app_routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_states.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late HomePageCubit homePageCubit;

  @override
  void initState() {
    super.initState();
    homePageCubit = BlocProvider.of<HomePageCubit>(context);
    homePageCubit.getFiles2();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocConsumer<HomePageCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          List<FileSystemEntity> st;
          if (state is FilesLoadedSuccessfull) {
            return Scaffold(
              appBar: AppBar(),
              body: PageView(
                controller: homePageCubit.pageController,
                children: List.generate(homePageCubit.files.length, (index) {
                  FileSystemEntity entity = homePageCubit.files[index];
                  return Stack(
                    children: [
                      Text(entity.path),
                      InkWell(
                        onTap: () {
                          print("${entity.path} $index");
                          print(
                              "${homePageCubit.controller.getCurrentDirectory} $index");
                        },
                        child: Image(
                          image: FileImage(
                            File(
                              entity.absolute.path,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  FileManager.requestFilesAccessPermission();
                  if (await Permission.accessMediaLocation.status.isGranted) {
                  } else {
                    Permission.accessMediaLocation.request();
                  }
                },
                label: const Text("Request File Access Permission"),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
