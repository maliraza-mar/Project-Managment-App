import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/user_side_pages/dashboard.dart';
import 'package:project_app/user_side_pages/insights.dart';
import 'package:project_app/user_side_pages/projects_navbarpages.dart';

import 'common/sizes.dart';
import 'controllers/userside_pages_controller.dart';

class UserSidePages extends StatefulWidget {
  const UserSidePages({super.key});

  @override
  State<UserSidePages> createState() => _UserSidePagesState();
}

class _UserSidePagesState extends State<UserSidePages> {
  final UsersidePagesController controller = Get.put(UsersidePagesController());
  int currentTab = 0;

  Widget currentScreen = const Dashboard();

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children: const [
                  //Screen 1
                  Dashboard(),
              
                  //Screen 2
                  ProjectsNavBarPages(),
              
                  //Screen3
                  Insights(),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade200,
          height: sizes.height70,
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
                  icon: Icons.list_alt,
                  page: 1,
                  label: 'Projects',
                ),

                _bottomAppBarItems(context,
                  icon: Icons.bar_chart,
                  page: 2,
                  label: 'Insights',
                )
              ],
            ),
          ),
        ),


      )
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

