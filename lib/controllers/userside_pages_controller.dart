import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UsersidePagesController extends GetxController {
  late PageController pageController;

  //Variable for changing index of Bottom AppBar
  RxInt currentPage = 0.obs;

  void goToTab (int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}