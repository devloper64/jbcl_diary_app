import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jbcl_assesment_diary_app/screen/home/component/note_field.dart';
import 'package:jbcl_assesment_diary_app/screen/home/details_screen.dart';


import '../../constants.dart';
import '../../model/diary_model.dart';
import '../../size_config.dart';
import 'component/tittle_field.dart';
import 'controller/home_controller.dart';

class HomeScreen extends GetView<HomeController>{

  const HomeScreen({super.key});




  @override
  Widget build(BuildContext context) {

    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    var formatter = DateFormat('yyyy-MM-dd');

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Diary App"),backgroundColor: kColorPrimary,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kColorPrimary,
        onPressed: () async {

          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
            ),

            builder: (BuildContext context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BuildTittleFormField(),
                      SizedBox(height: getProportionateScreenHeight(20),),
                      const BuildNoteFormField(),
                      SizedBox(height: getProportionateScreenHeight(20),),
                      ElevatedButton(
                        onPressed: () {
                          _getFromGallery();
                        },
                        child: Text("PICK FROM GALLERY"),
                      ),
                  Obx(()=>
                    controller.imageFile.value.path!=""?SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.file(
                        controller.imageFile.value,
                        fit: BoxFit.cover,
                      ),
                     ):Container(),
                  ),
                      SizedBox(height: getProportionateScreenHeight(40),),
                      InkWell(
                        borderRadius:  const BorderRadius.all(Radius.circular(40)),
                        highlightColor: Colors.black.withOpacity(0.4),
                        splashColor: Colors.black.withOpacity(0.4),
                        onTap: () async {
                          var box =
                              await Hive.openBox<DiaryModel>('diary');
                          if(controller.tittleController.text!=""&& controller.noteController.text!=""&& controller.imageFile.value.path!="") {
                            box.add(DiaryModel(id: random(5, 6),
                                tittle: controller.tittleController.text,
                                note: controller.noteController.text,
                                image: controller.imageFile.value.path,date: formatter.format(DateTime.now())));
                            controller.getDiary();
                            controller.tittleController.text = "";
                            controller.noteController.text = "";
                            controller.imageFile.value = File("");
                            Get.back();
                          }else{
                            Fluttertoast.showToast(
                                msg: "Please Fill Up All Field",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM);
                          }
                        },
                        child: Container(
                          width: SizeConfig.screenWidth,
                          height: getProportionateScreenHeight(45),
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              boxShadow:  const [
                                BoxShadow(
                                  color: colorBlueShadow,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: Offset(1, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50),
                              color: introButtonColor),
                          child: const Center(
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );



        },
        child: const Icon(Icons.add),
      ),
      body: Obx(()=>controller.diaryList.isNotEmpty?Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
          itemCount: controller.diaryList.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key:  UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                final box = await Hive.openBox<DiaryModel>('diary');
                box.deleteAt(index);
                controller.diaryList.removeAt(index);
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: GestureDetector(
                onTap: (){
                  Get.to(DiaryDetailsScreen(controller.diaryList[index], index));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: getProportionateScreenWidth(88),
                        child: AspectRatio(
                          aspectRatio: 0.88,
                          child: Container(
                            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.file(File(controller.diaryList[index].image)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: getProportionateScreenWidth(220),
                            child: Text(
                              controller.diaryList[index].tittle,
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                              maxLines: 2,
                            ),
                          ),

                          Text(
                            controller.diaryList[index].date,
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                            maxLines: 2,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ),
          ),
        ),
      ):
      const Center(child: Text("No Note Found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),)
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      controller.imageFile.value = File(pickedFile.path);
    }
  }

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

}