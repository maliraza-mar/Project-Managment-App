import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_app/user_side_pages/projects_navbar_pages/projects_details.dart';
import 'package:get/get.dart';
import '../../common/sizes.dart';
import '../../utilities/fetch_projects_count.dart';
import '../../widgets/users_projectstime_container.dart';
import '../../widgets/userside_compmisstodo_container.dart';

class CompletedProjects extends StatefulWidget {
  const CompletedProjects({super.key});

  @override
  State<CompletedProjects> createState() => _CompletedProjectsState();
}

class _CompletedProjectsState extends State<CompletedProjects> {
  final EmployeeProjectCountFetched empSideDetails = EmployeeProjectCountFetched();

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
            padding: EdgeInsets.symmetric(horizontal: sizes.width20, vertical: sizes.height20),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectsDetails()));
            },
            child: Text(''),
            // const UsersProjectsTimeContainer(
            //   iconColor: Colors.transparent,
            //   projectsTitle: '',
            // ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectsDetails()));
            },
            child: Text(''),
            // const UsersProjectsTimeContainer(
            //   iconColor: Colors.transparent,
            //   projectsTitle: '',
            // ),
          ),

        ],
      ),
    );
  }
}
