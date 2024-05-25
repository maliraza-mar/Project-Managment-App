import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_pages/add_new_project.dart';
import '../app_pages/chat_screen.dart';
import '../app_pages/project_details.dart';
import '../common/sizes.dart';
import '../controllers/employee_controller.dart';
import '../controllers/projects_controller.dart';
import '../utilities/utils.dart';
import '../widgets/my_projects_in_progress.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final ProjectsController controller = Get.put(ProjectsController());
  int currentId = 1001;
  bool isLoading = true;
  final EmployeeController employeeController = Get.put(EmployeeController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // for generating unique id for two different users
  // String generateRoomId(String user1, String user2) {
  //   // Sort the user IDs or email addresses to ensure consistency
  //   List<String> sortedUsers = [user1, user2]..sort();
  //   return '${sortedUsers[0]}_${sortedUsers[1]}';
  // }

  List allNewImagesAdded = [];

  @override
  void initState() {
    super.initState();
    getImageUrl();
    fetchEmployeeDetails(employeeController.users.toString());
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(title: const Text(
            'Projects', style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.grey.shade100,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: sizes.height10,
          ), //top = 10
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                    indicatorPadding: EdgeInsets.symmetric(
                      horizontal: sizes.width20, //left = 20
                    ),
                    tabs: const [
                      Tab(
                        child: Text('In Progress', style: TextStyle(color:
                        Colors.black),),),
                      Tab(
                        child: Text('Completed', style: TextStyle(color:
                          Colors.black),),),]),
              ),
              SizedBox(
                height: sizes.height510,
                child: TabBarView(children: [
                  //Projects tab
                  ListView.builder(
                      itemCount: isLoading ? 1 : allNewImagesAdded.length,
                      itemBuilder: (context, index) {
                        //var projectData = allNewImagesAdded[index];
                        if (isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var projectData = allNewImagesAdded[index]; // Get project data
                          var imageUrl = allNewImagesAdded[index]['imageUrl'];
                          var projectTitle = allNewImagesAdded[index]['Project Title'];
                          var employeeName = allNewImagesAdded[index]['Full Name'];
                          var projectId = allNewImagesAdded[index]['Project Id'];
                          // Fetch employee details
                          return FutureBuilder<Map<String, dynamic>>(
                            future: fetchEmployeeDetails(employeeName),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                // Data has been successfully fetched
                                final employeeDetails = snapshot.data!;
                                if (kDebugMode) {
                                  print('Employee Details are: $employeeDetails');
                                }
                                return MyProjectsInProgress(
                                  title: projectTitle,
                                  titleId: projectId,
                                  imageUrl: imageUrl,
                                  employeeName: employeeName,
                                  projectId: projectId,
                                  projectData: projectData,
                                  usersData: employeeDetails,
                                );
                              }
                            },
                          );
                        }
                      }),
                  // Project Completed Section
                  ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              height: sizes.height220,
                              //height approx. = 220.6
                              width: sizes.width320,
                              //height approx. = 320
                              margin: EdgeInsets.only(
                                top: sizes.height20, //top = 20
                                left: sizes.width20, //left = 20
                                right: sizes.width20, //left = 20
                                bottom: sizes.height20, //top = 20
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 10),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(sizes
                                    .responsiveBorderRadius20), //borderRadius = 20
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: sizes.height5, //top = 5
                                      left: sizes.width20, //left = 20
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              sizes.responsiveBorderRadius30),
                                          //borderRadius = 30
                                          child: Image.network(
                                            'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=600',
                                            width: sizes.width100,
                                            //width approx. = 100
                                            height: sizes
                                                .height100, //height approx. = 100
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: sizes.height15,
                                            //top = 15
                                            left: sizes.width20, //left = 20
                                          ),
                                          child: Column(
                                            children: [
                                              const Text('New House'),
                                              SizedBox(
                                                height:
                                                    sizes.height5, //height = 5
                                              ),
                                              const Text(
                                                'ID:  1001',
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                      left: 20,
                                    ),
                                    child: Text('Status :  Completed'),
                                  ),
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _twoButton(
                                          context,
                                          index: 0,
                                          button: 0,
                                          label: 'Details',
                                        ),
                                        _twoButton(
                                          context,
                                          button: 1,
                                          index: 1,
                                          label: 'Message',
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ));
                      }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _twoButton(BuildContext context, {required index, required button, required label,}) {
    return InkWell(
      onTap: () async {
        String currentUser = _auth.currentUser!.uid;
        // String employeeName = allNewImagesAdded[index]['Full Name'];
        //
        // //Fetch employee details
        // Map<String, dynamic> employeeDetails = await fetchEmployeeDetails(employeeName);
        // String user2 = employeeDetails['Uid'];
        // String user2Email = employeeDetails['Email'];
        //
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => button == 0
        //             ? ProjectDetails(
        //                 projectData: {},
        //                 updateIsChecked: (bool) {},
        //               )
        //             : ChatScreen(
        //                 receiverUserEmail: user2Email,
        //                 receiverUserId: user2,
        //                 usersData: employeeDetails,
        //               )));

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

  // ImageUrl is get to display image
  void getImageUrl() async {
    try {
      List<Map<String, dynamic>> image =
      await StoreNewProjectFireStore().getAllDetails();
      setState(() {
        allNewImagesAdded = image;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching names: $e');
      }
      Utils().toastMessage('Error fetching names: $e');
    }
  }

  Future<Map<String, dynamic>> fetchEmployeeDetails(String employeeName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Employee')
          .where('Full Name', isEqualTo: employeeName)
          .get();

      // Fetching the details of the employee
      Map<String, dynamic> employeeDetails = {};
      if (querySnapshot.docs.isNotEmpty) {
        employeeDetails =
            querySnapshot.docs[0].data() as Map<String, dynamic>? ?? {};
      }

      return employeeDetails;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching details for $employeeName: $e');
      }
      return {}; // Return empty map on error
    }
  }

}
