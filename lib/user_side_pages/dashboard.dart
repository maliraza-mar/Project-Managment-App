import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/employees_chat_list.dart';
import 'package:project_app/utilities/fetch_projects_count.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_pages/sign_in.dart';
import '../app_pages/splash_screen.dart';
import '../common/sizes.dart';
import '../model/user_model.dart'; // Assuming UserModel is imported from the correct path
import '../widgets/userside_compmisstodo_container.dart';
import '../widgets/userside_home_container.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final EmployeeProjectCountFetched empSideDetails = EmployeeProjectCountFetched();
  final ValueNotifier<UserModel?> _loggedInEmployee = ValueNotifier<UserModel?>(null);

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      await empSideDetails.fetchLoggedInEmployee();
      _loggedInEmployee.value = empSideDetails.getLoggedInEmployee;
      await empSideDetails.fetchEmployeeProjectsCount(_loggedInEmployee.value?.fullName ?? '');
    } catch (e) {
      print('Error initializing data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: sizes.width20, top: sizes.height5),
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout_outlined, color: const Color(0xff07aeaf), size: sizes.responsiveIconSize30,),
            ),
          ],
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
        ),
        body: _buildBody(sizes),
      ),
    );
  }

  Widget _buildBody(Sizes sizes) {
    return ValueListenableBuilder<UserModel?>(
      valueListenable: _loggedInEmployee,
      builder: (context, loggedInEmployee, _) {
        if (loggedInEmployee == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return  Column(
          children: [
            Container(height: sizes.height140, width: sizes.width320,
              margin: EdgeInsets.only(
                  top: sizes.height10, left: sizes.width20,
                  right: sizes.width20, bottom: sizes.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius6),
                color: const Color(0xff07aeaf),
              ),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: EdgeInsets.only(left: sizes.width15, ),
                        child: Text('Hi ${empSideDetails.getLoggedInEmployee?.fullName ?? ''},',
                          style: TextStyle(color: Colors.white,
                              fontSize: sizes.responsiveFontSize28),),),
                      Padding(padding: EdgeInsets.only(right: sizes.width20,
                            top: sizes.height7),
                        child: CircleAvatar(radius: sizes.responsiveImageRadius23,
                          backgroundImage: NetworkImage(empSideDetails.getLoggedInEmployee?.imageUrl
                              ?? ''),),)],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: sizes.height25, left: sizes.width15),
                        child: Column(
                          children: [ ///assigned task
                            Text('Jul 26, 2023', style: TextStyle(fontSize: sizes.responsiveFontSize18,
                                  color: Colors.white),),
                            Padding(padding: EdgeInsets.only(right: sizes.width10),
                              child: FutureBuilder<Map<String, int>>(
                                future: empSideDetails.fetchEmployeeProjectsCount(_loggedInEmployee.value?.fullName ?? ''),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    final projectsCount = snapshot.data?[_loggedInEmployee.value?.fullName ?? ''] ?? 0;
                                    return Text('${projectsCount ?? 0} task assigned',
                                      style: TextStyle(fontSize: sizes.responsiveFontSize12, color: Colors.white),
                                    );
                                  }
                                },
                              ),
                            ),],),),
                      Container(height: sizes.height40, width: sizes.width40,
                        margin: EdgeInsets.only(top: sizes.height35, right: sizes.width24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius50),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white, width: sizes.width3),

                        ),
                        child: Center(///project count
                          child: FutureBuilder<Map<String, int>>(
                            future: empSideDetails.fetchEmployeeProjectsCount(empSideDetails.getLoggedInEmployee?.fullName ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final projectsCount = snapshot.data![empSideDetails.getLoggedInEmployee?.fullName ?? ''];
                                return Text('0/${projectsCount ?? 0}',
                                  style: TextStyle(fontSize: sizes.responsiveFontSize14, color: Colors.white),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width20, vertical: sizes.height20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const UsersideHomeContainer(
                    title: 'Notifications',
                    message: 'Important notifications from management, consumer, team etc.',
                    icon: Icons.notifications_none_outlined,
                  ),
                  UsersideHomeContainer(
                    onTap: () {
                      Get.to( () => const EmployeesChatList());
                    },
                    title: 'Messages',
                    message: 'You can communicate here with teammates and your fellows',
                    icon: Icons.chat_outlined,
                  ),

                ],
              ),
            ),

            UsersideCompMissTodoContainer(
              titleName: 'Projects',
              containerColor: Colors.white,
              numbersColor: Colors.black,
              textColor: Colors.grey.shade400,
              toDo: FutureBuilder<Map<String, int>>(
                future: empSideDetails.fetchEmployeeProjectsCount(empSideDetails.getLoggedInEmployee?.fullName ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final projectsCount = snapshot.data![empSideDetails.getLoggedInEmployee?.fullName ?? ''];
                    return Column(
                      children: [
                        Text('${projectsCount ?? 0}', style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold, fontSize: sizes.responsiveFontSize23,),
                        ),
                        Text('To do', style: TextStyle(color: Colors.grey.shade400),),
                      ],
                    );
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }

  void logout() async {
    var sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool(SplashScreenState.keyLogin, false);
    Get.to(() => const SignIn());
  }
}
