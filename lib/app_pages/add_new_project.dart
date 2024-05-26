import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_app/widgets/my_app_bar.dart';
import '../common/sizes.dart';
import '../controllers/employee_controller.dart';
import '../utilities/employee_total_projects.dart';
import '../model/user_model.dart';
import '../resources/auth_method.dart';
import '../resources/storage_methods.dart';
import '../utilities/utils.dart';
import 'package:get/get.dart';

import '../widgets/my_dropdown_container.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_field.dart';
import '../widgets/round_button.dart';
import '../widgets/select_image.dart';

class AddNewProject extends StatefulWidget {
  AddNewProject({super.key, this.user});

  late final UserModel? user;

  @override
  State<AddNewProject> createState() => AddNewProjectState();
}

class AddNewProjectState extends State<AddNewProject> {
  final titleController = TextEditingController();
  final projectIdController = TextEditingController();
  final budgetController = TextEditingController();
  final EmployeeController _employeeController = Get.find<EmployeeController>();

  // Fetch employee names
  List employeesNamesList = [];
  String? valueChoose;
  String status = 'In Progress';

  // Pick image
  Uint8List? _image;
  String? selectedImageName;

  bool loading = false;
  Map<String, int> totalProjects = {};

  //DatePicked
  DateTime? selectedDate; // Declare the selectedDate variable

  @override
  void initState() {
    super.initState();
    _employeeController.fetchEmployees();
    fetchEmployeesNames();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: const Color(0xff07aeaf),
      appBar: const MyAppBar(
        title: 'Add New Project',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: sizes.height10),
            child: Container(height: sizes.height677,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(sizes.responsiveBorderRadius40),
                      topLeft:
                          Radius.circular(sizes.responsiveBorderRadius40))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sizes.height10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [SizedBox(
                          height: sizes.height10,
                        ),
                        const MyText(text: 'Project Title'),
                        MyTextFormField(
                            controller: titleController,
                            hintText: 'Project Title'),
                        const MyText(text: 'Project ID'),
                        MyTextFormField(
                            controller: projectIdController,
                            hintText: 'unique project id i.e. 101'),
                        const MyText(text: 'Budget'),
                        MyTextFormField(
                            controller: budgetController, hintText: '\$500'),
                        const MyText(text: 'Deadline'),
                        Container(
                          height: sizes.height55,
                          margin:
                              EdgeInsets.symmetric(horizontal: sizes.width20),
                          //padding: EdgeInsets.only(top: sizes.height5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                sizes.responsiveBorderRadius10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: sizes.width12),
                                child: Text(
                                  selectedDate != null
                                      ? DateFormat('d MMM yyyy')
                                          .format(selectedDate!)
                                      : 'Select Date',
                                  style: TextStyle(
                                    color: selectedDate != null
                                        ? Colors.black
                                        : Colors.grey.shade600,
                                    fontSize: sizes.responsiveFontSize16,
                                  ),
                                ),
                              ),
                              IconButton(
                                  padding: EdgeInsets.only(right: sizes.width5),
                                  onPressed: () {
                                    datePicked();
                                  },
                                  icon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.grey.shade400,
                                  ))
                            ],
                          ),
                        ),
                        const MyText(text: 'Select Employee'),
                        MyDropDownContainer(
                          text: 'Select Employee',
                          itemsList: employeesNamesList,
                          value: valueChoose,
                          onChanged: (value) {
                            valueChoose = value.toString();
                          },
                        ),
                        const MyText(text: 'Attachment'),
                        SelectImage(
                          onTap: selectImage,
                          selectedImageName:
                          selectedImageName != null
                              ? (selectedImageName!.length > 10
                              ? '${selectedImageName!.substring(0, 10)}...'
                              : selectedImageName!)
                              : 'Image name',
                        ),
                      ],
                    ),
                    ///Add Button
                    RoundButton(
                      title: 'Add',
                      onTap: addNewProject,
                      loading: loading,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Employee names are displayed in the dropdownButton
  void fetchEmployeesNames() {
    List<String?> names =
    _employeeController.users.map((user) => user.fullName).toList();
    employeesNamesList.clear(); // Clear the list before updating
    employeesNamesList.addAll(names.toSet().toList()); // Remove duplicates
  }

  Future<void> updateTotalProjects(String employeeUid) async {
    try {
      // Get a reference to the employee document
      DocumentReference employeeRef =
      FirebaseFirestore.instance.collection('Employee').doc(employeeUid);

      // Get the current value of totalProjects
      DocumentSnapshot employeeSnapshot = await employeeRef.get();
      int currentTotalProjects = employeeSnapshot['Total Projects'] ?? 0;

      // Increment the totalProjects count
      int updatedTotalProjects = currentTotalProjects + 1;

      // Update the employee document
      await employeeRef.update({'Total Projects': updatedTotalProjects});

      print('Total projects updated successfully for employee $employeeUid');
    } catch (e) {
      print('Error updating total projects: $e');
    }
  }

  void selectImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String fileName = pickedFile.name; // Extracting the file name
      Uint8List imageBytes = await pickedFile.readAsBytes();

      setState(() {
        _image = imageBytes;
        selectedImageName = fileName;
      });
    }
  }

  Future datePicked() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(3000),
    );

    setState(() {
      if (pickDate != null) {
        selectedDate = pickDate;
      }
    });
  }

  void addNewProject() async {
    setState(() {
      loading = true;
    });

    // Get the UID of the selected employee
    String? employeeUid = await AuthMethod().getEmployeeUid(valueChoose!);
    String title = titleController.text;
    String projectId = projectIdController.text;
    bool projectIdExists = await checkProjectIdExists(projectId);

    if (projectIdExists) {
      Utils().toastMessage('Project Id already Exists');
      String? lastAddedProjectId = await getLastAddedProjectId();
      if (lastAddedProjectId != null) {
        int nextProjectId = int.parse(lastAddedProjectId) + 1;
        projectIdController.text = nextProjectId.toString();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Suggested Project ID: $nextProjectId')));
      }
      setState(() {
        loading = false;
      });
      return;
    }

    String budget = budgetController.text;
    String deadline = selectedDate != null
        ? DateFormat('d MMM yyyy').format(selectedDate!)
        : '';
    String selectedEmployee = valueChoose ?? '';
    String attachment = selectedImageName ?? '';
    String photoUrl =
    await StorageMethods().uploadImageToStorage('ProjectImage', _image!);

    String projectAssignedId = generateProjectAssignId(selectedEmployee);

    // Add the project to Firestore
    String? result = await StoreNewProjectFireStore().addProject(
      projectId: projectId,
      title: title,
      budget: budget,
      deadline: deadline,
      employeeFullName: selectedEmployee,
      attachment: attachment,
      imageUrl: photoUrl,
      status: status,
      assignedManProId: projectAssignedId,
    );

    // Check if employeeUid is not null before proceeding
    if (employeeUid != null) {
      // Assign the project to the employee using their UID
      // Update totalProjects for the employee in Firestore
      //updateTotalProjects(employeeUid);
      await updateTotalProjects(employeeUid);
    } else {
      // Handle case where employee with the selected name was not found
      print('Employee with name $valueChoose not found');
    }

    if (result == 'Success') {
        Utils().toastMessage('Project added successfully');
    } else {
      Utils().toastMessage('Error adding project: $result');
    }

    setState(() {
      loading = false;
    });
  }

  //func for assiging id to a person to whom project is assigned
  String generateProjectAssignId(String userName) {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return '$userName-$timestamp';
  }

  // Function to check if project Id already exists
  Future<bool> checkProjectIdExists(String projectId) async {
    try {
      CollectionReference projectCollection =
          FirebaseFirestore.instance.collection('Projects');
      final snapShot = await projectCollection.where('Project Id', isEqualTo: projectId).get();
      return snapShot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking project ID: $e');
      return false; // Assume project ID doesn't exist on error
    }
  }

  //Function to check what is the last id that has added in the project.
  Future<String?> getLastAddedProjectId() async {
    try {
      CollectionReference projectCollection =
          FirebaseFirestore.instance.collection('Projects');
      final snapShot = await projectCollection
          .orderBy('Project Id', descending: true)
          .limit(1)
          .get();
      if (snapShot.docs.isNotEmpty) {
        return snapShot.docs.first['Project Id'];
      }
      return null;
    } catch (e) {
      print('Error fetching last added project Id $e');
      return null;
    }
  }
}

class StoreNewProjectFireStore {
  Future<String?> addProject({
    required String title,
    required String projectId,
    required String budget,
    required String deadline,
    required String employeeFullName,
    required String attachment,
    required String imageUrl,
    required String status,
    required String assignedManProId,
  }) async {
    try {
      CollectionReference projectCollection =
      FirebaseFirestore.instance.collection('Projects');

      // Generate a unique document ID for each project
      //String documentId = projectCollection.doc().id;

      // Store project data using the generated document ID
      await projectCollection.doc(projectId).set({
        //'DocumentId': documentId, // Store the generated document ID
        'Project Title': title,
        'Project Id': projectId,
        'Budget': budget,
        'Deadline': deadline,
        'Full Name': employeeFullName,
        'Attachment': attachment,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'status': status,
        'AssignedProId': assignedManProId,
      });
    } catch (e) {
      print('Error adding project: $e');
      return 'Error adding project: $e';
    }
    return 'Success';
  }


  Future<List<Map<String, dynamic>>> getAllDetails() async {
    List<Map<String, dynamic>> projects = [];
    try {
      CollectionReference projectCollection = FirebaseFirestore.instance.collection('Projects');
      final snapShot = await projectCollection.orderBy('timestamp', descending: false).get();

      for (var doc in snapShot.docs) {
        projects.add(doc.data() as Map<String, dynamic>);
      }
      return projects;
    } catch (e) {
      print('Error fetching all Project Details $e');
      throw e;
    }
  }
}
