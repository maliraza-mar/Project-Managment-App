import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/message.dart';


class LocalDatabase {

  SharedPreferences? _sharedPreferences;
  String key = DateTime.now().millisecondsSinceEpoch.toString();

  //create a stream controller for local messages
  final StreamController<List<Message>> _localMessagesStreamController = StreamController<List<Message>>() ;
  //Expose the stream to provide local messages
  Stream<List<Message>> get localMessagesStream => _localMessagesStreamController.stream ;

  void initPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // Future<void> displayMessagesWithStatus() async{
  //   final List<Message> messages = await getLocalMsgs();
  //
  //   for(Message message in messages){
  //     if(message.status == ChatStatus.sent){
  //       const Icon(Icons.done, color: Colors.white, size: 14,);
  //       print('Message Sent : ${message.message}');
  //     } else if(message.status == ChatStatus.delivered){
  //       const Icon(Icons.done_all, color: Colors.white, size: 14,);
  //       print('Message Delivered : ${message.message}');
  //     } else if(message.status == ChatStatus.seen){
  //       const Icon(Icons.done_outline, color: Colors.brown, size: 14,);
  //     }
  //   }
  // }

  Future<void> saveChatLocally(List<Message> messages) async{
    //List<Message> messages = await getLocalMsgs();
    //List<Message> messages = _sharedPreferences?.setString(key, message.toString()) as List<Message>;
    //messages.add(message);
    final jsonMsgs = messages.map((msg) => msg.toMap()).toList();
    final jsonStrMsgs = jsonEncode(jsonMsgs);
    _sharedPreferences?.setString(key, jsonStrMsgs);
    _localMessagesStreamController.add(messages) ;
    print('Saved chat : $messages');
  }

  Future<List<Message>> getLocalMsgs() async{
    final jsonStrMsgs = _sharedPreferences?.getString(key);
    //print('Message y h : $jsonStrMsgs');
    if(jsonStrMsgs != null){
      final jsonMsgs = jsonDecode(jsonStrMsgs);
      if(jsonMsgs is List){
        return jsonMsgs.map((json) => Message.fromMap(json)).toList();
      }
    }
    return [];
  }

  //Close the stream controller when it's no longer needed
  void dispose() {
    _localMessagesStreamController.close();
  }

}