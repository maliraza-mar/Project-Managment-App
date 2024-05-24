import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavBarPageController extends GetxController {
  RxInt currentPage = 0.obs;
  late PageController pageController;

  NavBarPageController() {
    pageController = PageController();
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void reset() {
    currentPage.value = 0;
    pageController.dispose();
    pageController = PageController();
  }
}
