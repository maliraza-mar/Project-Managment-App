import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';


class ChatService extends ChangeNotifier{
  // get instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String messageId = '';
  //Send Message
  Future<Message> sendMessage(String receiverId, String message) async{
    //get currentUser Info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final DateTime dateTime = DateTime.now();
    final sendTime = dateTime.toIso8601String();
    messageId = _firestore.collection('chat_room').doc().id;
    bool isSeen = false;

    //create a new message
    Message newMessage = Message(
        senderId: currentUserId,
        receiverId: receiverId,
        message: message,
        sendTime: sendTime,
        messageId: messageId,
        isSeen: isSeen,
        status: 'sent'
    );

    //construct chatRoomId from currentUserId and receiverId (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    //add new message to database
    await _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .set(newMessage.toMap());
    //.add(newMessage.toMap());

    return newMessage;
  }

  //Get Message to database
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
    //construct chatRoomId from currentUserId and receiverId (sorted to ensure uniqueness)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();

  }

// void listenToReceiverOnlineStatus(String receiverId, Function(bool) statusCallback) {
//   _firestore.collection('users').doc(receiverId).snapshots().listen((event) {
//     if (event.exists) {
//       final data = event.data();
//       final status = data?['status'];
//       // Check if the receiver is online
//       final isOnline = status == 'online';
//       statusCallback(isOnline);
//     }
//   });
// }
}