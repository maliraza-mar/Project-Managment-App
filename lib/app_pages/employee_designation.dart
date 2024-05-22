import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/sizes.dart';
import '../controllers/employee_controller.dart';
import '../utilities/utils.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_dropdown_container.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_field.dart';
import '../widgets/round_button.dart';

class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({super.key, });

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  final EmployeeController _employeeController = Get.find<EmployeeController>();
  final employeeDesignationController = TextEditingController();
  final utils = Utils();
  // Fetch employee names
  List employeesNamesList = [  ];
  String? valueChoose;
  List employeesEmailsList = [  ];
  String? chooseMail;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchEmployeesNames();
    fetchEmployeesEmails();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: const Color(0xff07aeaf),
      appBar: MyAppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          iconSize: sizes.responsiveFontSize18,
        ),
        title: 'Employee Designation',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: sizes.height148),
            child: Container(
              height: sizes.height540,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(sizes.responsiveBorderRadius40),
                      topLeft: Radius.circular(sizes.responsiveBorderRadius40),
                  ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sizes.height10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: sizes.height15),                 //height given = 15
                        //Employee name Selected
                        const MyText(text: 'Name'),
                        MyDropDownContainer(
                          text: 'Select Name',
                          itemsList: employeesNamesList,
                          value: valueChoose,
                          onChanged: (value) {
                            valueChoose = value.toString();
                          },
                        ),

                        //Employee mail selected
                        const MyText(text: 'Enter Email'),
                        MyDropDownContainer(
                          text: 'Select Email',
                          itemsList: employeesEmailsList,
                          value: chooseMail,
                          onChanged: (value) {
                            chooseMail = value.toString();
                          },
                        ),

                        //Employee Designation
                        const MyText(text: 'Designation'),
                        MyTextFormField(
                          controller: employeeDesignationController,
                          hintText: 'designation',
                          prefixIcon: Icon(Icons.policy_outlined, color: Colors.grey.shade400,),
                        ),
                      ],
                    ),


                    RoundButton(title: 'Update', onTap: updateEmployeeDesignation, loading: loading,)

                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }

  void fetchEmployeesNames() {
    List<String?> names = _employeeController.users.map((user) => user.fullName).toList();
    employeesNamesList.clear(); // Clear the list before updating
    employeesNamesList.addAll(names.toSet().toList()); //removes duplicate
  }
  void fetchEmployeesEmails() {
    List<String?> emails = _employeeController.users.map((user) => user.email).toList();
    employeesEmailsList.clear(); // Clear the list before updating
    employeesEmailsList.addAll(emails.toSet().toList()); //removes duplicate
  }

  void updateEmployeeDesignation() async {
    if (valueChoose == null || chooseMail == null || employeeDesignationController.text.isEmpty) {
      utils.toastMessage("Please fill all fields");
      return;
    }
    setState(() {
      loading = true;
    });

    try {
      // Assuming you have a method in your EmployeeController to update the designation
      await _employeeController.updateEmployeeDesignation(chooseMail!, employeeDesignationController.text);

      utils.toastMessage("Designation updated successfully");
    } catch (e) {
      utils.toastMessage("Failed to update designation: $e");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

}

