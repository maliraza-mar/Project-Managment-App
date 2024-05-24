import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_pages/add_new_project.dart';
import '../app_pages/employee_details.dart';
import '../common/sizes.dart';
import '../controllers/employee_controller.dart';
import '../model/user_model.dart';
import '../widgets/employee_image_container.dart';
import '../widgets/projects_progress_containers.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final EmployeeController employeeController = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: sizes.height30,
                left: sizes.width24,
                bottom: sizes.height15,
              ),
              child: Text('Employees', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizes.responsiveFontSize17,
                ),),),
            Obx(() {
              return Container(height: sizes.height110,
                margin: EdgeInsets.symmetric(
                  horizontal: sizes.width13,
                ),
                child: SizedBox(height: sizes.height110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: employeeController.users.length,
                    itemBuilder: (context, index) {
                      UserModel user = employeeController.users[index];
                      return EmployeeImageCircleAvatar(
                        imageUrl: user.imageUrl.toString(),
                        imageName: user.fullName.toString(),
                        onTap: () {
                          Get.to(() => EmployeeDetails(user: user));
                          // Not sure what you're intending with this line
                          AddNewProject(user: user);},);},),),);
            }),
            Padding(
              padding: EdgeInsets.only(
                left: sizes.width24,
                top: sizes.height26,
              ),
              child: Text('Projects', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizes.responsiveFontSize17,
                ),),),

            Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width24),
              child: ProjectProgressContainers(
                figureText: employeeController.totalProjectsCount.toInt(),
                wordText: 'To Do Task',
              ),
            ),),
            Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width24),
              child: ProjectProgressContainers(
                figureText: employeeController.completedProjectsCount.toInt(),
                wordText: 'Completed',
              ),
            ),),

          ],
        ),
      ),
    );
  }
}
