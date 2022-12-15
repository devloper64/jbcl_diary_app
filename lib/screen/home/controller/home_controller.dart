import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../model/diary_model.dart';

class HomeController extends GetxController with StateMixin {

  RxList<DiaryModel> diaryList=<DiaryModel>[].obs;

  Rx<File> imageFile=File("").obs;

  late TextEditingController tittleController;
  var tittle = '';

  late TextEditingController noteController;
  var note = '';

  @override
  void onInit() {
    super.onInit();
    tittleController = TextEditingController();
    noteController = TextEditingController();

    getDiary();
  }


  void getDiary() async {
    final box = await Hive.openBox<DiaryModel>('diary');
    diaryList.value=box.values.toList().reversed.toList();
  }


}