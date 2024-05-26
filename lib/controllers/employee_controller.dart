import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';
import '../resources/auth_method.dart';

class EmployeeController extends GetxController {
  final AuthMethod authMethod = AuthMethod();
  final users = <UserModel>[].obs;
  final adminUsers = <UserModel>[].obs;
  UserModel? loggedInEmployee;
  RxList<Map<String, dynamic>> projectProgress = <Map<String, dynamic>>[].obs;

  RxInt totalProjectsCount = 0.obs;
  RxInt completedProjectsCount = 0.obs;

  @override
  void onInit() {
    fetchTotalProjectsCount();
    // TODO: implement onInit
    super.onInit();
    fetchEmployees();
    fetchTotalProjectsCount();
  }

  void fetchEmployees() async {
    List<UserModel> fetchedUsers = await authMethod.getEmployees();
    print("Fetched Users: $fetchedUsers");
    users.assignAll(fetchedUsers);
    print("Assigned Users: ${users.length}");
  }

  void fetchAdmin() async {
    try {
      List<UserModel> fetchedAdmin = await authMethod.getAdmin();
      adminUsers.clear();
      adminUsers.assignAll(fetchedAdmin);
      //adminUsers.add(fetchedAdmin);
      print('After calling getAdmin(): $fetchedAdmin');
    } catch (e) {
      print('Error fetching admin: $e');
    }
  }

  Future<void> fetchTotalProjectsCount() async {
    try {
      CollectionReference<Map<String, dynamic>> projectCollection =
      FirebaseFirestore.instance.collection('Employee');

      // Initialize the total and completed counts
      int total = 0;
      int completed = 0;

      // Set up a snapshot listener on the collection
      projectCollection.snapshots().listen((snapshot) {
        total = 0;
        completed = 0;

        // Iterate through each document in the collection
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          // Check if the 'Total Projects' field exists in the document
          if (doc.data().containsKey('Total Projects')) {
            total += (num.tryParse(doc['Total Projects'].toString()) ?? 0).toDouble().toInt();
          }

          if (doc.data().containsKey('Completed Projects')) {
            completed += (num.tryParse(doc['Completed Projects'].toString()) ?? 0).toDouble().toInt();
          }
        }

        // Update the project counts
        totalProjectsCount.value = total;
        completedProjectsCount.value = completed;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching project counts: $e');
      }
      // Set counts to 0 on error
      totalProjectsCount.value = 0;
      completedProjectsCount.value = 0;
    }
  }

  // Method to fetch employee ID by email
  Future<String?> getEmployeeIdByEmail(String email) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Employee')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching employee ID: $e');
    }
  }

  // Method to update employee designation
  Future<void> updateEmployeeDesignation(String email, String newDesignation) async {
    try {
      String? documentId = await getEmployeeIdByEmail(email);
      if (documentId != null) {
        await FirebaseFirestore.instance
            .collection('Employee')
            .doc(documentId)
            .update({'Role': newDesignation});
        // Optionally update the local list of users if needed
        var employee = users.firstWhere((user) => user.email == email);
        employee.role = newDesignation;
        update(); // Update the state
      } else {
        throw Exception('Employee not found');
      }
    } catch (e) {
      throw Exception('Error updating designation: $e');
    }
  }

  Future<void> fetchProjectProgress() async {
    try {
      CollectionReference<Map<String, dynamic>> projectCollection = FirebaseFirestore.instance.collection('Employee');
      QuerySnapshot<Map<String, dynamic>> snapshot = await projectCollection.get();

      List<Map<String, dynamic>> progressData = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        if (doc.data().containsKey('date') && doc.data().containsKey('completedProjects')) {
          progressData.add({
            'date': (doc['date'] as Timestamp).toDate(),
            'completedProjects': (doc['completedProjects'] ?? 0) as int,
          });
        }
      }

      projectProgress.assignAll(progressData);
    } catch (e) {
      projectProgress.assignAll([]);
    }
  }
}
