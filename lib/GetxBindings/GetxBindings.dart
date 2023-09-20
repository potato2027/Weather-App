import 'package:get/get.dart';
import 'package:untitled/viewmodels/HomeController.dart';

class GetxBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}