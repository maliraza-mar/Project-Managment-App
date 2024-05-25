import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:project_app/resources/storage_methods.dart';

import '../model/user_model.dart';

class AuthMethod{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async{
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('Users').doc(currentUser.email).get();

    return UserModel.fromSnap(snap);
  }

  // signup user
  Future<String> signupUser({
    required String fullName,
    required String email,
    required String password,
    required Uint8List file,
    required String role,
  }) async {
    String res = 'Some error occurred';

    try {
      if (fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty &&
          file != null && role.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        if (cred.user != null) {
          String photoUrl =
          await StorageMethods().uploadImageToStorage('ProfilePic', file);
          // Get the current count of employees for the given role
          int employeeCount = await getEmployeeCount(role);

          // Append the count to the role name to create a unique document name
          String uniqueDocumentName = '$role${employeeCount + 1}';
          // Create a DateTime object for the current date and time
          Timestamp joiningDate = Timestamp.now();

          UserModel user = UserModel(
            fullName: fullName,
            imageUrl: photoUrl,
            email: email,
            password: password,
            uid: cred.user!.uid,
            role: role,
            joiningDate: joiningDate,
          );

          //await _firestore.collection('Users').doc(uniqueDocumentName).set(user.toJson());
          String collectionName = role == 'Admin' ? 'Admin' : 'Employee';
          await _firestore.collection(collectionName).doc(cred.user!.uid).set(user.toJson());

          res = 'success';
        }
      }
    } catch (e) {
      res = 'Error during user registration: $e';
    }

    return res;
  }

  // Method to get the count of employees for a given role
  Future<int> getEmployeeCount(String role) async {
    try {
      QuerySnapshot querySnapshot =
      await _firestore.collection(role).get();

      return querySnapshot.size;
    } catch (e) {
      print("Error fetching employee count: $e");
      return 0;
    }
  }

  Future<List<UserModel>> getAdmin() async {
    List<UserModel> admin = [];

    try {
      QuerySnapshot querySnapshot =
      await _firestore.collection('Admin').get();

      admin = querySnapshot.docs
          .map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          fullName: data['Full Name'] ?? '',
          imageUrl: data['User Image'] ?? '',
          email: data['Email'] ?? '',
          role: data['Role'] ?? '',
        );
      }).toList();
    } catch (e) {
      print("Error fetching employees: $e");
    }

    return admin;
  }

  //getting employees
  Future<List<UserModel>> getEmployees() async {
    List<UserModel> employees = [];

    try {
      QuerySnapshot querySnapshot =
      await _firestore.collection('Employee').get();

      employees = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          fullName: data['Full Name'] ?? '',
          imageUrl: data['User Image'] ?? '',
          email: data['Email'] ?? '',
          role: data['Role'] ?? '',
        );
      }).toList();
    } catch (e) {
      print("Error fetching employees: $e");
    }

    return employees;
  }

  // Function to retrieve the UID of an employee based on their name
  Future<String?> getEmployeeUid(String employeeName) async {
    try {
      // Query the Firestore collection to find the employee document by name
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Employee')
          .where('Full Name', isEqualTo: employeeName)
          .limit(1)
          .get();

      // Check if the query returned any documents
      if (querySnapshot.docs.isNotEmpty) {
        // Return the UID from the retrieved employee document
        return querySnapshot.docs.first['Uid'];
      } else {
        // Employee not found with the given name
        print('Employee not found with name: $employeeName');
        return null;
      }
    } catch (e) {
      print('Error retrieving employee UID: $e');
      return null;
    }
  }

}