import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/sizes.dart';
import '../widgets/round_button.dart';

class ProjectDetails extends StatefulWidget {
  final Map<String, dynamic> projectData;
  final Function(bool) updateIsCompleted;
  const ProjectDetails({super.key,
    required this.projectData, required this.updateIsCompleted,
  });

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {

  int currentId = 1001;
  DateTime? createdAt;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    creationDate();
    isCompleted = widget.projectData['status'] == 'Completed';
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
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
          iconSize: sizes.responsiveFontSize18,
        ),
        title: const Text(
          'Project Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: sizes.height10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  //top: sizes.height5,
                  left: sizes.width20,
                ),
                child: Row(
                  children: [

                    widget.projectData.isNotEmpty && widget.projectData.containsKey('imageUrl')
                        ? Uri.tryParse(widget.projectData['imageUrl']) != null  //if it is a valid URL using the Uri.tryParse method
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius30),
                          child: Image.network(
                            widget.projectData['imageUrl'],
                            width: sizes.width100,
                            height: sizes.height100,
                          ),
                        )
                        : const Text('Invalid Image URL')
                        : const Text('No Image Available'),

                    Padding(
                      padding: EdgeInsets.only(
                        bottom: sizes.height20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: sizes.width13),
                            child: Text(
                              '${widget.projectData.isNotEmpty ? widget.projectData['Project Title'] : 'N/A'}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: sizes.height5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: sizes.width13),
                            child: Text(
                              'ProjectID:  ${widget.projectData.isNotEmpty ? widget.projectData['Project Id'] : 'N/A'}',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //Project Info part here
              Padding(
                padding: EdgeInsets.only(
                  left: sizes.width20,
                  //top: 5
                ),
                child: Text(
                  'Project Info',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: sizes.responsiveFontSize17,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
                child: Text(
                  'Created At:   ${createdAt != null ? DateFormat('d MMM yyyy').format((createdAt!)) : "N/A"}',
                  // 'Created At:   ${createdAt != null ? DateFormat('d MMM yyyy').format(createdAt!) : "N/A"}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
                child: Text(
                  'Deadline:   ${widget.projectData.isNotEmpty ? widget.projectData['Deadline'] : "N/A"}',
                  // 'Deadline:   ${allProjects.isNotEmpty ? allProjects.last['Deadline'] : "N/A"}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
                child: Text(
                  'Budget:   \$${widget.projectData.isNotEmpty ? widget.projectData['Budget'] : 'N/A'}',
                  // 'Budget:   ${allProjects.isNotEmpty ? allProjects.last['Budget'] : 'N/A'}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
                child: Text(
                  'Status:   ${widget.projectData['status'] ?? (isCompleted ? 'Completed' : 'In Progress')}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),

              //Employee Info Part Here
              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height15),
                child: Text(
                  'Employee Info',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: sizes.responsiveFontSize17),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
                child: Text(
                  'Name:   ${widget.projectData.isNotEmpty ? widget.projectData['Full Name'] : 'N/A'}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
                child: Text(
                  'Out Source:  \$${widget.projectData.isNotEmpty ? widget.projectData['Budget'] : 'N/A'}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: sizes.width20,),
                    child: const Text(
                      'Project Completed?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Checkbox(
                      value: isCompleted,
                      activeColor: Colors.black,
                      onChanged: (bool? value){
                        if (value != null) {
                          setState(() {
                            isCompleted = value;
                          });
                          updateProjectStatus(widget.projectData['Project Id'], value);
                        }
                      }
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height15),
                child: Text(
                  'Instructions',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: sizes.responsiveFontSize20),
                ),
              ),

              //TextForm Field here for a message from user
              Padding(
                padding: EdgeInsets.symmetric(vertical: sizes.height20, horizontal: sizes.width20),
                child: TextFormField(
                  minLines: 3,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'enter a message here',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),

              //TextButton of Update Status here
              SizedBox(
                height: sizes.height26,
              ),
              //RoundButton(title: 'Edit Project Info', onTap: (){})
            ],
          ),
        ),
      ),
    );
  }

  //Created At, becomes to the date when project is created.
  void creationDate() {
      if (createdAt == null) {
        var createdAtMillies = DateTime.now().millisecondsSinceEpoch;
        createdAt = DateTime.fromMillisecondsSinceEpoch(createdAtMillies);
      }
  }

  Future<void> updateProjectStatus(String projectId, bool isCompleted) async {
    try {
      // Update project status
      await FirebaseFirestore.instance.collection('Projects').doc(projectId).update({
        'status': isCompleted ? 'Completed' : 'In Progress',
        'completedDate': isCompleted ? Timestamp.now() : null,
      });

      // Query the Employee collection to get the document for the given employee's name
      QuerySnapshot employeeQuerySnapshot = await FirebaseFirestore.instance
          .collection('Employee')
          .where('Full Name', isEqualTo: widget.projectData['Full Name'])
          .get();

      if (employeeQuerySnapshot.docs.isNotEmpty) {
        // Get the UID of the employee from the first document in the query result
        String employeeUid = employeeQuerySnapshot.docs.first.id;

        // Get the employee's current completed projects count
        DocumentSnapshot employeeDoc = await FirebaseFirestore.instance.collection('Employee').doc(employeeUid).get();
        int completedProjects = employeeDoc['Completed Projects'] ?? 0;
        int totalProjects = employeeDoc['Total Projects'] ?? 0;

        // Update the employee's completed projects count
        await FirebaseFirestore.instance.collection('Employee').doc(employeeUid).update({
          'Completed Projects': isCompleted ? completedProjects + 1 : completedProjects - 1,
          'Total Projects': isCompleted ? totalProjects - 1 : totalProjects + 1, // Decrease the total projects count
        });
      } else {
        print('Employee document does not exist.');
      }

      // Notify parent widget about the change
      if (mounted) {
        widget.updateIsCompleted(isCompleted);
      }
    } catch (e) {
      print('Error updating project status: $e');
    }
  }

}
