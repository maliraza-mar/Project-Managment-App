import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/resources/auth_method.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_pages/profile.dart';
import '../app_pages/employee_designation.dart';
import '../app_pages/sign_in.dart';
import '../app_pages/splash_screen.dart';
import '../common/sizes.dart';
import '../controllers/employee_controller.dart';
import '../controllers/navbar_page_controller.dart';
import '../model/user_model.dart';
import '../widgets/my_card.dart';

class Admin extends StatefulWidget {
  final UserModel? user;
  const Admin({super.key, this.user});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final AuthMethod _authMethod = AuthMethod();
  String currentUserImage = '';
  String? currentUserName;
  List allNewImagesAdded = [];
  final EmployeeController employeeController = Get.put(EmployeeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageUrl();
    getUserName();
    // Call fetchAdmin when the widget is initialized
    employeeController.fetchAdmin();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: sizes.width5, top: sizes.height10),
              onPressed: (){
                logout();
              },
              icon: Icon(
                Icons.logout_outlined,
                color: const Color(0xff07aeaf),
                size: sizes.responsiveIconSize30,
              )
          )
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: sizes.height55, right: sizes.width5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius66),
                  border: Border.all(color: Colors.black, width: 1)),
              child: CircleAvatar(
                radius: sizes.responsiveImageRadius65,
                backgroundImage: currentUserImage != 'N/A'
                  ? NetworkImage(currentUserImage)
                    : null,
              ),),),
          Padding(
            padding: EdgeInsets.only(top: sizes.height10, right: sizes.width5),
            child: Text(
              currentUserName.toString(), style: TextStyle(
                fontSize: sizes.responsiveFontSize20,
                fontWeight: FontWeight.bold,
              ),),),
          SizedBox(height: sizes.height70,),
          MyCard(
            title: 'Profile', onTap: () {
              try {
                // Check if there's any user in the list
                if (employeeController.adminUsers.isNotEmpty) {
                  // Get the first user from the list and navigate to EditProfile screen
                  Get.to(() => Profile(user: employeeController.adminUsers.single));
                } else {
                  // Log an error if adminUsers is empty
                  if (kDebugMode) {
                    print('Admin user not found');
                  }
                }
              } catch (e) {
                // Log any caught errors during navigation
                if (kDebugMode) {
                  print('Error navigating to EditProfile: $e');
                }
              }
            },
            leading: const Icon(Icons.person_pin_outlined),
          ),
          MyCard(
            title: 'Employee Designation', onTap: () {
            Get.to( () => const AddNewEmployee());
          },
            leading: const Icon(Icons.people_outline_outlined),
          ),

          //Logout card
          MyCard(
            title: 'Logout', onTap: () => logout(),
            leading: const Icon(Icons.event_note_outlined),
          ),

        ],
      ),
    );
  }

  void getImageUrl() async {
    try {
      List<UserModel> adminList = await _authMethod.getAdmin();
      if (adminList.isNotEmpty) {
        setState(() {
          currentUserImage = adminList.first.imageUrl ?? '';
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching image: $e');
      }
      // Handle error
    }
  }

  void getUserName() async {
    try {
      List<UserModel> adminList = await _authMethod.getAdmin();
      if (adminList.isNotEmpty) {
        setState(() {
          currentUserName = adminList.first.fullName ?? '';
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching username: $e');
      }
      // Handle error
    }
  }


  //Logout krny k liy Function
  void logout () async {
    var sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool(SplashScreenState.keyLogin, false);

    // Reset the NavBarPageController
    NavBarPageController controller = Get.find();
    controller.reset();
    Get.delete<NavBarPageController>();

    Get.to( () => const SignIn());
  }
}
