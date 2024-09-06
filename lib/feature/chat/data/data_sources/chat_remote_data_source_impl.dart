import 'package:educatly_task/feature/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource{

  final DatabaseReference _database = FirebaseDatabase.instance.ref();


  @override
  Future<void> sendMessage(String message , String senderId , String receiverId) async{
        _database.child('chatRooms')
        .child(receiverId)
        .child('messages');
    String? messageId = _database.push().key;
    Map<String, dynamic> messageData = {
      'messageId': messageId,
      'senderId': senderId,
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

        _database.child(messageId!).set(messageData).then((_) {
      debugPrint('Message sent successfully');
    }).catchError((error) {
      debugPrint('Failed to send message: $error');
    });
  }

  @override
  Future<String> reveiveMessage() async{
    String message = '';
    return message;
  }

  @override
  Future<List<Map<String, dynamic>>> getChatHistory(String receiverId) async{
        _database.child('chatRooms')
        .child(receiverId)
        .child('messages');
    DatabaseEvent event = await _database.once();
    List<Map<String, dynamic>> messages = [];
    if (event.snapshot.value != null) {
      Map<dynamic, dynamic>? messagesMap = event.snapshot.value as Map<dynamic, dynamic>?;

      messagesMap?.forEach((key, value) {
        Map<String, dynamic> message = Map<String, dynamic>.from(value);
        messages.add(message);
      });
    }
    print(messages);
    return messages;
  }
}