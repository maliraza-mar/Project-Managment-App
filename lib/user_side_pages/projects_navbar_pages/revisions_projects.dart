import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/sizes.dart';
import '../../utilities/fetch_projects_count.dart';
import '../../widgets/users_projectstime_container.dart';
import '../../widgets/userside_compmisstodo_container.dart';

class RevisionProjects extends StatefulWidget {
  const RevisionProjects({super.key});

  @override
  State<RevisionProjects> createState() => _RevisionProjectsState();
}

class _RevisionProjectsState extends State<RevisionProjects> {
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

          // const UsersProjectsTimeContainer(
          //   iconColor: Colors.transparent,
          //   projectsTitle: '',
          // ),
          //
          // const UsersProjectsTimeContainer(
          //   iconColor: Colors.transparent,
          //   projectsTitle: '',
          // ),

        ],
      ),
    );
  }
}
