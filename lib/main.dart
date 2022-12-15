import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jbcl_assesment_diary_app/model/diary_model.dart';
import 'package:jbcl_assesment_diary_app/screen/home/home_screen.dart';
import 'package:jbcl_assesment_diary_app/theme.dart';
import 'binding/global_binding.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  GlobalBinding().dependencies();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DiaryModelAdapter());
  runApp(GetMaterialApp(
        title: "Diary App",
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home:  HomeScreen(),
      ));
}