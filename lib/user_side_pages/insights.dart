import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/sizes.dart';
import '../utilities/fetch_projects_count.dart';
import '../widgets/userside_compmisstodo_container.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  final EmployeeProjectCountFetched empSideDetails = EmployeeProjectCountFetched();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      await empSideDetails.fetchLoggedInEmployee();
      await empSideDetails.fetchEmployeeProjectsCount(empSideDetails.getLoggedInEmployee?.fullName ?? "");
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(backgroundColor: Colors.grey.shade100,
          automaticallyImplyLeading: false,
          title: const Text('Insights', style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.black),),
          centerTitle: true, elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.width20, vertical: sizes.height20),
              child: UsersideCompMissTodoContainer(
                titleName: '',
                containerColor: const Color(0xff07aeaf),
                textColor: Colors.white,
                numbersColor: Colors.white,
                toDo: Obx(() => Column(
                  children: [
                    Text(
                      '${empSideDetails.projectsCount.value}', // Access projects count from observable
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: sizes.responsiveFontSize23,
                      ),
                    ),
                    const Text(
                      'To do',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),),),
            //Text h Income Report ka
            Padding(
              padding: EdgeInsets.only(top: sizes.height15, left: sizes.width18),
              child: Text('Income Report', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sizes.responsiveFontSize23,
                    color: Colors.black),),),
            //Graph Chart or Bar Chart wala part h
            TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: const Color(0xff07aeaf),
              dividerColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              padding: EdgeInsets.symmetric(horizontal: sizes.width20, vertical: sizes.height20),
                tabs: const [
                  Tab(child: Text('Last Month', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('3M', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('6M', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Year', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('All', style: TextStyle(color: Colors.black),),),])
          ],
        ),
      ),
    );
  }
}
