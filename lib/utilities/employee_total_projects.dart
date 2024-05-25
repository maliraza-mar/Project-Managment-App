import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EmployeeTotalProjects{

  Future<void> updateTotalProjects(String? employeeUid) async {
    try {
      // Get a reference to the employee document
      DocumentReference employeeRef = FirebaseFirestore.instance.collection('Employee').doc(employeeUid);

      // Get the current value of totalProjects
      DocumentSnapshot employeeSnapshot = await employeeRef.get();
      int currentTotalProjects = employeeSnapshot.exists ? (employeeSnapshot['Total Projects'] ?? 0) : 0;

      // Increment the totalProjects count
      int updatedTotalProjects = currentTotalProjects + 1;

      // Update the totalProjects count using FieldValue.increment
      await employeeRef.update({
        'Total Projects': FieldValue.increment(1)
      });

      print('Total projects updated successfully for employee $employeeUid');
    } catch (e) {
      print('Error updating total projects: $e');
    }
  }
}

