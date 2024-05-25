import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/model/user_model.dart';
import 'package:project_app/resources/auth_method.dart';
import 'package:project_app/widgets/my_app_bar.dart';

import 'app_pages/chat_screen.dart';
import 'common/sizes.dart';


class EmployeesChatList extends StatefulWidget {
  const EmployeesChatList({super.key});

  @override
  State<EmployeesChatList> createState() => _EmployeesChatListState();
}

class _EmployeesChatListState extends State<EmployeesChatList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //late Stream<List<DocumentSnapshot<Object?>>> _combinedStream;
  late Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _combinedStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _combinedStream = _combineStreams(
      _firestore.collection('Admin').snapshots(),
      _firestore.collection('Employee').snapshots(),
    );
  }

  //Displayed both Admin and Employees in the same ChatList
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _combineStreams(
      Stream<QuerySnapshot<Map<String, dynamic>>> stream1,
      Stream<QuerySnapshot<Map<String, dynamic>>> stream2,
      ) {
    return StreamZip([stream1, stream2]).map((combinedData) {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> list1 =
      combinedData[0].docs.map((doc) => doc as QueryDocumentSnapshot<Map<String, dynamic>>).toList();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> list2 =
      combinedData[1].docs.map((doc) => doc as QueryDocumentSnapshot<Map<String, dynamic>>).toList();
      return [...list1, ...list2];
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          iconSize: sizes.responsiveIconSize18,
        ),
        title: 'Chats',
      ),

      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                    stream: _combinedStream,
                    builder: (context, AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>> snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading') ;
                      }
                      if(snapshot.hasError){
                        print('Error: ${snapshot.error}');
                        return Text('Error: ${snapshot.error}');
                      }
                      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.data ?? [];
                      if (docs.isEmpty) {
                        return const Text('No Admin available');
                      }
                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          return _buildUserListItem(docs[index]);
                        },
                      );
                    }
                )

              ),
            ],
          )
        ],
      ),
    );
  }

  // build Individual user list item
  Widget _buildUserListItem(QueryDocumentSnapshot<Map<String, dynamic>> document) {
    Map<String, dynamic> data = document.data();
    final sizes = Sizes(context);
    print('This is the $data');

    if (_auth.currentUser!.email != data['Email']) {
      return Container(
        margin: EdgeInsets.only(top: sizes.height5),
        padding: EdgeInsets.symmetric(horizontal: sizes.width8,),
        height: sizes.height65,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: sizes.height5),
          child: ListTile(
            leading: CircleAvatar(
              radius: sizes.responsiveImageRadius25,
              backgroundImage: NetworkImage(data['User Image']),
            ),
            title: Text(data['Full Name']),
            trailing: const Text('2:30 PM'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    receiverUserEmail: data['Email'],
                    receiverUserId: data['Uid'],
                    usersData: data,
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

}

//_firestore.collection('Users').snapshots().map((snapshot) => snapshot.docs.toList(),)