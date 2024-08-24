import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    homePageCubit.getFiles();
  }

  @override
  Widget build(BuildContext context) {
    homePageCubit = BlocProvider.of<HomePageCubit>(context);

    return ControlBackButton(
      controller: homePageCubit.controller,
      child: Scaffold(
        appBar: AppBar(),
        body: FileManager(
          controller: homePageCubit.controller,
          builder: (context, snapshot) {
            final List<FileSystemEntity> entities = snapshot;
            // return ListView.builder(
            //   padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            //   itemCount: entities.length,
            //   itemBuilder: (context, index) {
            //     FileSystemEntity entity = entities[index];
            //     return Card(
            //       child: ListTile(
            //         leading: FileManager.isFile(entity)
            //             ? const Icon(Icons.feed_outlined)
            //             : const Icon(Icons.folder),
            //         title: Text(FileManager.basename(
            //           entity,
            //           showFileExtension: true,
            //         )),
            //         onTap: () async {
            //           if (FileManager.isDirectory(entity)) {
            //             // open the folder
            //             homePageCubit.controller.openDirectory(entity);
            //             // delete a folder
            //             // await entity.delete(recursive: true);
            //
            //             // rename a folder
            //             // await entity.rename("newPath");
            //
            //             // Check weather folder exists
            //             // entity.exists();
            //
            //             // get date of file
            //             // DateTime date = (await entity.stat()).modified;
            //           } else {
            //             // delete a file
            //             // await entity.delete();
            //
            //             // rename a file
            //             // await entity.rename("newPath");
            //
            //             // Check weather file exists
            //             // entity.exists();
            //
            //             // get date of file
            //             // DateTime date = (await entity.stat()).modified;
            //
            //             // get the size of the file
            //             // int size = (await entity.stat()).size;
            //           }
            //         },
            //       ),
            //     );
            //   },
            // );
            return PageView(
              children: List.generate(homePageCubit.files.length, (index) {
                FileSystemEntity entity = homePageCubit.files[0];
                // FileSystemEntity entity = homePageCubit.controller.getCurrentDirectory.listSync();
                return Stack(
                  children: [
                    Text(entity.path),
                    InkWell(
                      onTap: () {
                        print("${entity.path} $index");
                        print("${homePageCubit.controller.getCurrentDirectory} $index");
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
            );
          },
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
      ),
    );


  }

  @override
  void initState() {
    homePageCubit = BlocProvider.of<HomePageCubit>(context);
    homePageCubit.getFiles2();
  }

}
