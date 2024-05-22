import 'package:flutter/material.dart';

import '../common/sizes.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(
              left: sizes.width13
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
            iconSize: sizes.responsiveIconSize18,
          ),
        ),
        leadingWidth: sizes.width40,
        title: const Text(
          'Reports',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: sizes.height15, horizontal: sizes.width13),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10)
            ),
            margin: EdgeInsets.symmetric(vertical: sizes.height10, horizontal: sizes.width10),
            elevation: 0,
            child: ListTile(
              title: const Text('April,2023'),
              trailing: const Icon(Icons.navigate_next_outlined),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius20)
              ),
            ),
          );
        }),
      ),
    );
  }
}
