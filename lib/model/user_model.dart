import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserModel {
  late final String? fullName;
  final String? imageUrl;
  late final String? contactNumber;
  late final String? email;
  final String? password;
  //final String? status;
  final String? uid;
  String? role;
  final int? totalProjects;
  final int? pendingProjects;
  final int? missedProjects;
  final int? completedProjects;
  final Timestamp? joiningDate;

  UserModel({
    this.fullName,
    this.imageUrl,
    this.contactNumber,
    this.email,
    this.password,
    //this.status,
    this.uid,
    this.role,
    this.totalProjects = 0,
    this.pendingProjects = 0,
    this.missedProjects = 0,
    this.completedProjects = 0,
    this.joiningDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'Full Name': fullName,
      'User Image': imageUrl,
      'Contact Number': contactNumber,
      'Email': email,
      'Password': password,
      //'Status' : status,
      'Uid': uid,
      'Role': role,
      'Total Projects': totalProjects,
      'Pending Projects': pendingProjects,
      'Missed Projects': missedProjects,
      'Completed Projects': completedProjects,
      'Joining Date': joiningDate,
    };
    //!= null ? DateFormat('d MMM yyyy').format(joiningDate!) : null
  }

  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    // Convert Timestamp to DateTime for joiningDate
    Timestamp? joiningDateTimestamp = snap['Joining Date'] as Timestamp?;
    DateTime? joiningDate;
    if (joiningDateTimestamp != null) {
      joiningDate = joiningDateTimestamp.toDate();
    }

    return UserModel(
      fullName: snap['Full Name'],
      imageUrl: snap['User Image'],
      contactNumber: snap['Contact Number'],
      email: snap['Email'],
      password: snap['Password'],
      //status: snap['Status'],
      uid: snap['Uid'],
      role: snap['Role'],
      totalProjects: snap['Total Projects'],
      pendingProjects: snap['Pending Projects'],
      missedProjects: snap['Missed Projects'],
      completedProjects: snap['Completed Projects'],
      joiningDate: snap['Joining Date'] as Timestamp?,
    );
  }
// != null ? (snap['joiningDate'] as Timestamp).toDate() : null

// != null ? DateFormat('d MMM yyyy').parse(snap['Joining Date']) : null
}
