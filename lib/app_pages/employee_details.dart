import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../common/sizes.dart';
import '../controllers/employee_controller.dart';
import '../utilities/employee_total_projects.dart';
import '../model/user_model.dart';
import '../widgets/my_projects_in_progress.dart';
import '../widgets/round_button.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  final EmployeeController employeeController = Get.put(EmployeeController());
  final EmployeeTotalProjects employeeTotalProjects = Get.put(EmployeeTotalProjects());

  List allNewImagesAdded = [];
  List<String> arrEarnings = [
    'April,2023',
    'March,2023',
    'Feb,2023',
  ];

  @override
  void initState() {
    super.initState();
    _updateTotalProjectsAndPrintCount();
    fetchEmployeeProjectsCount(widget.user.fullName.toString());
    fetchEmployeeProjects(widget.user.fullName.toString());
    fetchEmployeeDetails(widget.user.fullName.toString());
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            iconSize: sizes.responsiveIconSize18,
          ),
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Employee Image, Name, number
            Container(
              height: sizes.height90,
              margin: EdgeInsets.symmetric(horizontal: sizes.width20),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(sizes.responsiveBorderRadius10),
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(top: sizes.height5, left: sizes.width10),
                  leading: CircleAvatar(
                      radius: sizes.responsiveImageRadius30,
                      backgroundImage:
                          NetworkImage(widget.user.imageUrl.toString())),
                  title: Text(widget.user.fullName.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          sizes.responsiveBorderRadius10)),
                ),
              ),
            ),

            //Information of Employee
            Padding(
              padding:
                  EdgeInsets.only(left: sizes.width20, top: sizes.height20),
              child: const Text(
                'Personal Info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: sizes.width20, top: sizes.height10),
              child: Text(
                'Designation:  ${widget.user.role}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
              child: Text(
                'Joined:   ${widget.user.joiningDate != null ? DateFormat('d MMM yyyy').format(widget.user.joiningDate! as DateTime) : 'Unknown'}',
                style: const TextStyle(color: Colors.black),
              ),
            ),

            Padding(
              padding:
                  EdgeInsets.only(left: sizes.width20, top: sizes.height10),
              child: FutureBuilder<Map<String, int>>(
                future: fetchEmployeeProjectsCount(widget.user.fullName.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Data has been successfully fetched
                    final projectsCount =
                        snapshot.data![widget.user.fullName.toString()];
                    return Text('Total Projects: ${projectsCount ?? 0}');
                  }
                },
              ),
            ),

            Container(
              margin:
                  EdgeInsets.only(top: sizes.height30, bottom: sizes.height20),
              color: Colors.white,
              child: TabBar(
                  indicatorPadding: EdgeInsets.symmetric(
                    horizontal: sizes.width20,
                  ),
                  tabs: const [
                    Tab(
                      child: Text(
                        'Projects',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Earnings',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: sizes.height300,
              child: TabBarView(children: [
                TabBarView(children: [
                  //To display projects of each employee individually
                  FutureBuilder<QuerySnapshot<Object?>>(
                    future: fetchEmployeeProjects(widget.user.fullName.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text(
                          'No projects found',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ));
                      } else {
                        // Data has been successfully fetched
                        final projects = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> project =
                                projects[index].data() as Map<String, dynamic>;
                            var imageUrl =
                                project['imageUrl'] as String; // Cast to String
                            var projectTitle = project['Project Title']
                                as String; // Cast to String
                            var employeeName = project['Full Name']
                                as String; // Cast to String
                            var projectId = project['Project Id']
                                as String; // Cast to String

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
                                  return MyProjectsInProgress(
                                    title: projectTitle,
                                    titleId: projectId,
                                    imageUrl: imageUrl,
                                    employeeName: employeeName,
                                    projectId: projectId,
                                    projectData: project,
                                    usersData: employeeDetails,
                                  );
                                }
                              },
                            );
                          },
                        );
                      }
                    },
                  ),

                  // Earnings tab
                  Container(
                    color: Colors.grey.shade100,
                    padding: EdgeInsets.symmetric(
                        vertical: sizes.height12, horizontal: sizes.width13),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  sizes.responsiveBorderRadius10)),
                          margin: EdgeInsets.symmetric(
                              horizontal: sizes.width10,
                              vertical: sizes.height10),
                          elevation: 0.2,
                          child: ListTile(
                            title: Text(arrEarnings[index]),
                            trailing: const Text('300'),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    sizes.responsiveBorderRadius20)),
                          ),
                        );
                      },
                      itemCount: 3,
                    ),
                  ),
                ]),
                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.symmetric(
                      vertical: sizes.height12, horizontal: sizes.width13),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                sizes.responsiveBorderRadius10)),
                        margin: EdgeInsets.symmetric(
                            horizontal: sizes.width10,
                            vertical: sizes.height10),
                        elevation: 0.2,
                        child: ListTile(
                          title: Text(arrEarnings[index]),
                          trailing: const Text('300'),
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  sizes.responsiveBorderRadius20)),
                        ),
                      );
                    },
                    itemCount: 3,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateTotalProjectsAndPrintCount() async {
    try {
      await employeeTotalProjects.updateTotalProjects(widget.user.fullName,);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating total projects: $e');
      }
    }
  }

  Future<Map<String, int>> fetchEmployeeProjectsCount(String employeeName) async {
    try {
      CollectionReference projectCollection =
          FirebaseFirestore.instance.collection('NewProject');
      final snapShot = await projectCollection
          .where('Full Name', isEqualTo: employeeName)
          .get();
      int count = snapShot.docs.length;

      return {employeeName: count};
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching projects count for $employeeName: $e');
      }
      return {employeeName: 0}; // Return 0 on error
    }
  }

  Future<QuerySnapshot<Object?>> fetchEmployeeProjects(String employeeName) async {
    try {
      CollectionReference projectCollection =
          FirebaseFirestore.instance.collection('NewProject');
      final snapshot = await projectCollection
          .where('Full Name', isEqualTo: employeeName)
          .get();
      return snapshot;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching projects for $employeeName: $e');
      }
      throw e;
    }
  }

  Future<Map<String, dynamic>> fetchEmployeeDetails(String employeeName) async {
    try {
      CollectionReference projectCollection =
          FirebaseFirestore.instance.collection('Employee');
      final snapShot = await projectCollection
          .where('Full Name', isEqualTo: employeeName)
          .get();

      // Fetching the details of the employee
      Map<String, dynamic> employeeDetails = {};
      if (snapShot.docs.isNotEmpty) {
        employeeDetails =
            snapShot.docs[0].data() as Map<String, dynamic>? ?? {};
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
