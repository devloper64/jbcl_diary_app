import 'package:get/get.dart';

import '../screen/home/controller/home_controller.dart';

class GlobalBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
  }

}