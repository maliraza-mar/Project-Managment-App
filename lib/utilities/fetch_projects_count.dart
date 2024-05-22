import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:project_app/resources/auth_method.dart';

import '../model/user_model.dart';

class EmployeeProjectCountFetched extends GetxController {
  UserModel? loggedInEmployee;
  final AuthMethod authMethod = AuthMethod();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var projectsCount = 0.obs; // Projects count as observable
  RxList<QueryDocumentSnapshot<Object?>> totalProjects = RxList<QueryDocumentSnapshot<Object?>>();

  UserModel? get getLoggedInEmployee => loggedInEmployee;

  Future<Map<String, int>> fetchEmployeeProjectsCount(String employeeName) async {
    try {
      CollectionReference projectCollection = _firestore.collection('NewProject');
      final snapShot = await projectCollection.where('Full Name', isEqualTo: employeeName).get();
      int count = snapShot.docs.length;

      projectsCount.value = count; // Update projects count
      return {employeeName: count}; // Return the count
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching projects count for $employeeName: $e');
      }
      projectsCount.value = 0; // Return 0 on error
      return {employeeName: 0}; // Return the count as 0
    }
  }

  Future<void> fetchLoggedInEmployee() async {
    try {
      // Fetch the list of employees
      List<UserModel> employees = await authMethod.getEmployees();
      // Find the logged-in employee in the list using their email
      UserModel? logInEmployee;
      for (var employee in employees) {
        if (employee.email == auth.currentUser?.email) {
          logInEmployee = employee;
          break;
        }
      }
      // Update the state with the logged-in employee details
      loggedInEmployee = logInEmployee;
      update(); // Update GetX state
    } catch (e) {
      // Handle any errors that occur during the process
      if (kDebugMode) {
        print('Error fetching logged-in employee: $e');
      }
    }
  }

  Future<QuerySnapshot<Object?>> fetchEmployeeProjects(String employeeName) async {
    try {
      CollectionReference projectCollection = _firestore.collection('NewProject');
      final snapshot = await projectCollection.where('Full Name', isEqualTo: employeeName).get();

      // Update the totalProjects list with the fetched documents
      totalProjects.assignAll(snapshot.docs);

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
      CollectionReference projectCollection = _firestore.collection('Employee');
      final snapShot = await projectCollection.where('Full Name', isEqualTo: employeeName).get();

      // Fetching the details of the employee
      Map<String, dynamic> employeeDetails = {};
      if (snapShot.docs.isNotEmpty) {
        employeeDetails = snapShot.docs[0].data() as Map<String, dynamic>? ?? {};
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
