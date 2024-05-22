import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/sizes.dart';
import '../../utilities/fetch_projects_count.dart';
import '../../widgets/users_projectstime_container.dart';
import '../../widgets/userside_compmisstodo_container.dart';

class AllProjects extends StatefulWidget {
  const AllProjects({super.key});

  @override
  State<AllProjects> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
  final EmployeeProjectCountFetched empSideDetails = Get.put(EmployeeProjectCountFetched());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      await empSideDetails.fetchLoggedInEmployee();
      await empSideDetails.fetchEmployeeProjectsCount(empSideDetails.getLoggedInEmployee?.fullName ?? "");
      await empSideDetails.fetchEmployeeProjects(empSideDetails.getLoggedInEmployee?.fullName ?? "");
      empSideDetails.update();
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizes.width20,
                vertical: sizes.height20),
            child: UsersideCompMissTodoContainer(
              titleName: '',
              containerColor: Color(0xff07aeaf),
              textColor: Colors.white,
              numbersColor: Colors.white,
              toDo: Obx(() => Column(
                children: [
                  Text(
                    '${empSideDetails.projectsCount.value}', // Access projects count from observable
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: sizes.responsiveFontSize23,
                    ),
                  ),
                  const Text(
                    'To do',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,),),],)),),
          ),
          Expanded(
            child: Obx(() {if (empSideDetails.projectsCount.value == 0) {
                return const Center(
                  child: Text(
                    'No projects found', style: TextStyle(fontWeight:
                    FontWeight.bold),),);
              } else {
                return ListView.builder(
                  itemCount: empSideDetails.totalProjects.length, // Use totalProjects length directly
                  itemBuilder: (context, index) {
                    final project = empSideDetails.totalProjects[index].data() as Map<String, dynamic>;
                    var imageUrl = project['imageUrl'] as String;
                    var projectTitle = project['Project Title'] as String;
                    var projectId = project['Project Id'] as String;

                    return UsersProjectsTimeContainer(
                      iconColor: Colors.orangeAccent,
                      title: projectTitle,
                      titleId: projectId,
                      imageUrl: imageUrl,
                      projectId: projectId,
                      toDo: Obx(() => Row(
                        children: [
                          Text(
                            '${empSideDetails.projectsCount.value}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: sizes.responsiveFontSize23,
                            ),
                          ),
                          const Text(
                            'To do',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}


