import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jbcl_assesment_diary_app/screen/home/controller/home_controller.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BuildTittleFormField extends GetView<HomeController> {
  const BuildTittleFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.tittleController,
      style: const TextStyle(color: kTextColor, fontSize: 17),
      autofocus: false,
      keyboardType: TextInputType.text,
      maxLength: 200,
      onSaved: (value) {
        controller.tittle = value!;
      },
      decoration: const InputDecoration(
          counterText: "",
          labelText: "Tittle",
          labelStyle: TextStyle(
            color: kTextColor,
          ),
          contentPadding: EdgeInsets.fromLTRB(6, 15, 15, 0),
          enabledBorder:  UnderlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: editTextBorderColor)),
          border: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: kColorPrimary)),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: kColorPrimary)),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
    ));
  }
}
