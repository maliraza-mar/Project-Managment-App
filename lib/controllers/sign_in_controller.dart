import 'package:get/get.dart';

class SignInController extends GetxController {

  //Variable for changing index of 2 button created on SignIn screen
  RxInt currentButton = 0.obs;

  void goToButton (int button) {
    currentButton.value = button;
  }

}
