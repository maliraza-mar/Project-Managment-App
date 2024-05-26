import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProjectsController extends GetxController {
  //Variable for changing index of 2 Button in Projects Screen
  RxInt currentButton = 0.obs;

  void tapOnButton (int button) {
    currentButton.value = button;
  }
  RxList<Map<String, dynamic>> inProgressProjects = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> completedProjects = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    try {
      QuerySnapshot<Map<String, dynamic>> inProgressSnapshot =
          await FirebaseFirestore.instance
              .collection('Projects')
              .where('status', isEqualTo: 'In Progress')
              .get();

      QuerySnapshot<Map<String, dynamic>> completedSnapshot =
          await FirebaseFirestore.instance
              .collection('Projects')
              .where('status', isEqualTo: 'Completed')
              .get();

      inProgressProjects
          .assignAll(inProgressSnapshot.docs.map((doc) => doc.data()).toList());
      completedProjects
          .assignAll(completedSnapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      print('Error fetching projects: $e');
    }
  }

  void updateProjectLists() {
    fetchProjects();
  }
}
