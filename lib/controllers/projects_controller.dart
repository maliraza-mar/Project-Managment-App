import 'package:get/get.dart';

class ProjectsController extends GetxController {

  //Variable for changing index of 2 Button in Projects Screen
  RxInt currentButton = 0.obs;

  void tapOnButton (int button) {
    currentButton.value = button;
  }

}