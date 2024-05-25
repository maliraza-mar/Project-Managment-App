import 'package:flutter/material.dart';
import 'package:project_app/user_side_pages/projects_navbar_pages/all_projects.dart';
import 'package:project_app/user_side_pages/projects_navbar_pages/completed_projects.dart';
import 'package:project_app/user_side_pages/projects_navbar_pages/projects_details.dart';

import '../common/sizes.dart';

class ProjectsNavBarPages extends StatefulWidget {
  const ProjectsNavBarPages({super.key});

  @override
  State<ProjectsNavBarPages> createState() => _ProjectsNavBarPagesState();
}

class _ProjectsNavBarPagesState extends State<ProjectsNavBarPages> {

  List<Widget> screens = [
    AllProjects(),
    const CompletedProjects(),
    const ProjectsDetails(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = AllProjects();

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(                       //for wraping with new Widget Do this => (alt + enter)
        appBar: AppBar(
            backgroundColor: Colors.grey.shade100,

            automaticallyImplyLeading: false,
            title: const Text('Projects', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            centerTitle: true,
            // actions: [
            //   Padding(
            //     padding: EdgeInsets.only(right: sizes.width10),
            //     child: CircleAvatar(
            //       radius: sizes.responsiveImageRadius23,
            //       backgroundImage: const NetworkImage('https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_640.png'),
            //     ),
            //   ),
            // ],
            bottom: TabBar(
                indicatorPadding: EdgeInsets.symmetric(horizontal: sizes.width10),
                labelPadding: EdgeInsets.only(right: sizes.width5),
                labelColor: const Color(0xff07aeaf),
                indicatorColor: const Color(0xff07aeaf),
                splashFactory: NoSplash.splashFactory,
                unselectedLabelColor: Colors.grey.shade400,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                tabs: [
                  Tab(
                    iconMargin: EdgeInsets.only(bottom: sizes.height3),
                    icon: const Icon(Icons.home_outlined),
                    text: 'Home',
                  ),

                  Tab(
                    iconMargin: EdgeInsets.only(bottom: sizes.height3),
                    icon: const Icon(Icons.library_add_check_sharp),
                    text: 'Completed',
                  ),
                ]),
            elevation: 0,
          ),

        body: TabBarView(
            children: [
              AllProjects(),

              CompletedProjects(),
        ]),


      ),
    );
  }
}
