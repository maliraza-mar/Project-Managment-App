import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_pages/add_new_project.dart';
import 'common/sizes.dart';
import 'controllers/navbar_page_controller.dart';
import 'navbar_pages/admin.dart';
import 'navbar_pages/home.dart';
import 'navbar_pages/projects.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  late final NavBarPageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Initialize the controller here to ensure a fresh instance
    controller = Get.put(NavBarPageController());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizes = Sizes(context);
    double responsiveNotchMargin = size.width < size.height
        ? size.width * 0.03
        : size.height * 0.03;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              children: [
                Home(),
                AddNewProject(),
                Projects(),
                Admin(),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade200,
        height: sizes.height70,
        //shape: const CircularNotchedRectangle(),
        //notchMargin: responsiveNotchMargin,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              _bottomAppBarItems(context,
                icon: Icons.home_outlined,
                page: 0,
                label: 'Home',
              ),

              _bottomAppBarItems(context,
                icon: Icons.add_circle,
                page: 1,
                label: 'Add Project',
              ),

              _bottomAppBarItems(context,
                icon: Icons.list_alt,
                page: 2,
                label: 'Projects',
              ),

              _bottomAppBarItems(context,
                icon: Icons.person_pin_outlined,
                page: 3,
                label: 'Profile',
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItems(BuildContext context, {required icon, required page, required label}) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        controller.goToTab(page);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: controller.currentPage.value == page
                  ? const Color(0xff07aeaf)
                  : Colors.grey.shade500,
            ),
            Text(
              label,
              style: TextStyle(
                color: controller.currentPage.value == page
                    ? const Color(0xff07aeaf)
                    : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }


}


