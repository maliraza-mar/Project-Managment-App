
enum MsgStatus{sent, delivered, seen}

class Message{
  final String senderId;
  final String receiverId;
  final String message;
  final String sendTime;
  final String messageId;
  final bool isSeen;
  final String status;            // Isko ChatStatus dia h

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sendTime,
    required this.messageId,
    required this.isSeen,
    required this.status
  });

  Message.fromMap(Map<String, dynamic> map) :
      senderId = map['senderId'],
      receiverId = map['receiverId'],
      message = map['message'],
      sendTime = map['timestamp'],
      messageId = map['messageId'] ,
      isSeen = map['isSeen'],
      status = map['status'];         //ChatStatus.values[map['status']] //yhan status ko ChatStatus ki values m dia h

  // Define a method to convert a Message instance to a map
  Map<String, dynamic> toMap() {
    return{
      'senderId' : senderId,
      'receiverId' : receiverId,
      'message' : message,
      'timestamp' : sendTime,
      'messageId' : messageId,
      'isSeen' : isSeen,
      'status' : status      //yhan values hn isliy index kia h
    };
  }
}