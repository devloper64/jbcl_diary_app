import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jbcl_assesment_diary_app/screen/home/controller/home_controller.dart';

import '../../constants.dart';
import '../../model/diary_model.dart';
import '../../size_config.dart';

class DiaryDetailsScreen extends GetView<HomeController>{
  const DiaryDetailsScreen(this.diaryModel, this.index, {super.key});

  final DiaryModel diaryModel;
  final int index;


  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );

    return Scaffold(
        appBar: AppBar(title: const Text("Diary App"),backgroundColor: kColorPrimary,),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(

            margin: const EdgeInsets.all(10),

            child: Column(
              children: [

                Container(
                  height:SizeConfig.screenWidth! / 2,
                  width: SizeConfig.screenWidth,
                  child:Image.file(File(diaryModel.image)),
                ),

                const SizedBox(height: 20,),
                Text("${diaryModel.tittle}(${diaryModel.date})",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                const SizedBox(height: 20,),
                 Text(diaryModel.note,style: const TextStyle(color: Colors.black,fontSize: 20),),

              ],
            ),
          ),
        ),
        );

  }




}