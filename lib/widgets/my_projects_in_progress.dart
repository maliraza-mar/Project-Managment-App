import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_pages/chat_screen.dart';
import '../app_pages/project_details.dart';
import '../common/sizes.dart';
import '../controllers/employee_controller.dart';
import '../controllers/projects_controller.dart';
import '../model/user_model.dart';

class MyProjectsInProgress extends StatefulWidget {
  final Map<String, dynamic> projectData;
  final Map<String, dynamic> usersData;
  const MyProjectsInProgress({super.key,
    required this.title,
    required this.titleId,
    required this.imageUrl,
    required this.employeeName,
    required this.projectId,
    required this.projectData,
    required this.usersData,
  });

  final String title;
  final String titleId;
  final String imageUrl;
  final String employeeName;
  final String projectId;

  @override
  State<MyProjectsInProgress> createState() => _MyProjectsInProgressState();
}

class _MyProjectsInProgressState extends State<MyProjectsInProgress> {
  final ProjectsController controller = Get.put(ProjectsController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // for generating unique id for two different users
  String generateRoomId(String user1, String user2, String projectId) {
    // Sort the user IDs or email addresses to ensure consistency
    List<String> sortedUsers = [user1, user2]..sort();
    return '${sortedUsers[0]}_${sortedUsers[1]}_$projectId';
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Container(
      height: sizes.height220,      //height approx. = 220.6
      width: sizes.width320,        //height approx. = 320
      margin: EdgeInsets.symmetric(vertical: sizes.height20, horizontal: sizes.width20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10),
        ],
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(sizes.responsiveBorderRadius20), //borderRadius = 20
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: sizes.height5,        //top = 5
              left: sizes.width5,        //left = 20
            ),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius30),
                    child: Image.network(
                      widget.imageUrl,
                      width: sizes.width100,                       //width approx. = 100
                      height: sizes.height100,                    //height approx. = 100
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: sizes.height15,                //top = 15
                    left: sizes.width20,                  //left = 20
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.title ?? 'N/A',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: sizes.responsiveFontSize18),
                      ),
                      SizedBox(
                        height: sizes.height5,                //height = 5
                      ),
                      Text(
                        'ID:  ${widget.titleId}',
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: sizes.height5,                //top = 5
              left: sizes.width20,                  //left = 20
            ),
            child: Text('Assigned to: ${widget.employeeName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _twoButton(
                  context,
                  button: 0,
                  label: 'Details',
                  projectId: widget.projectId,
                ),
                _twoButton(
                  context,
                  button: 1,
                  label: 'Message',
                  projectId: widget.projectId,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _twoButton(BuildContext context, {required button, required label, required String projectId}) {
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          print("projectId: $projectId");
        }
        final currentUserId = _auth.currentUser?.email;
        String user2 = widget.usersData['Uid'] ?? '';
        //final secondUserId = currentUserId != otherUserId;
        String roomId = generateRoomId(currentUserId!, user2, projectId);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => button == 0
                    ? ProjectDetails(
                        projectData: widget.projectData,
                        updateIsChecked: (bool) {},
                      )
                    : ChatScreen(
                        receiverUserEmail: roomId, receiverUserId: user2,
                        usersData: widget.usersData,
                        // chatRoomId: roomId,
                      )));

        controller.tapOnButton(button);
      },
      child: Container(
        width: 125,
        height: 50,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: controller.currentButton.value == button
              ? const Color(0xff07aeaf)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: controller.currentButton.value == button
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
