// import 'package:flutter/material.dart';
// import 'package:my_app/app_pages/employee_details.dart';
// import 'package:my_app/common/sizes.dart';
//
// import '../app_pages/employee_designation.dart';
// import '../app_pages/add_new_project.dart';
// import '../app_pages/sign_up.dart';
// import '../utilities/utils.dart';
//
// class Employees extends StatefulWidget {
//   final Function fetchEmployeeProjectsCount;
//   const Employees({super.key, required this.fetchEmployeeProjectsCount});
//
//   @override
//   State<Employees> createState() => _EmployeesState();
// }
//
// class _EmployeesState extends State<Employees> {
//
//   List<Map<String, dynamic>> allAddedEmployees = [ ];
//   List<Map<String, dynamic>> employeeProjectsCount = [  ];
//   bool isloading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchEmployeesDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sizes = Sizes(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Employees', style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black),),
//         centerTitle: true,
//         backgroundColor: Colors.grey.shade100,
//         automaticallyImplyLeading: false,
//         elevation: 0,
//       ),
//       body: Container(
//         color: Colors.grey.shade100,
//         padding: EdgeInsets.symmetric(vertical: sizes.height15, horizontal: sizes.width10),
//         child: ListView.builder(
//           itemCount: isloading ? 1 : allAddedEmployees.length,
//           itemBuilder: (context, index) {
//             if (isloading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               var empImagesId = allAddedEmployees[index]['Employee Image'];
//               var empNames = allAddedEmployees[index]['Full Name'];
//               return Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10)
//                 ),
//                 margin: EdgeInsets.symmetric(vertical: sizes.height10, horizontal: sizes.width10),
//                 elevation: 0,
//                 child: ListTile(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetails(empData: allAddedEmployees[index], totalProjects: widget.fetchEmployeeProjectsCount(empNames),)));
//                   },
//                   leading: CircleAvatar(
//                     radius: sizes.responsiveImageRadius23,
//                     backgroundImage: NetworkImage(empImagesId),
//                   ),
//                   title: Text(empNames ?? 'N/A'),
//                   trailing: const Icon(Icons.navigate_next_outlined),
//                   tileColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius20)
//                   ),
//                 ),
//               );
//             }
//         },
//         ),
//       ),
//     );
//   }
//
//   void fetchEmployeesDetails() async {
//     try {
//       List<Map<String, dynamic>> names = await AddNewEmployeeFireStore().getAllEmpDetails();
//
//       // Fetch totalProjects for each employee
//       List<Map<String, int>> projectCounts = [];
//       for (var employee in names) {
//         Map<String, int> projectsCount = await widget.fetchEmployeeProjectsCount(employee['Full Name']);
//         projectCounts.add(projectsCount);
//       }
//
//       setState(() {
//         allAddedEmployees = names;
//         employeeProjectsCount = projectCounts;
//         isloading = false;
//       });
//     } catch (e) {
//       print('Error fetching names: $e');
//       Utils().toastMessage('Error fetching names: $e');
//     }
//   }
//
//
// // void fetchEmployeesDetails() async {
//   //   try {
//   //     List<Map<String, dynamic>> names = await AddNewEmployeeFireStore().getAllEmpDetails();
//   //
//   //     setState(() {
//   //       allAddedEmployees = names;
//   //       print('Details added');
//   //       employeeProjectsCount = names;
//   //
//   //     });
//   //   } catch (e) {
//   //     print('Error fetching names: $e');
//   //     Utils().toastMessage('Error fetching names: $e');
//   //   }
//   // }
//
//
// }
