import 'package:educatly_task/feature/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource{

  final DatabaseReference _database = FirebaseDatabase.instance.ref();


  @override
  Future<void> sendMessage(String message , String senderId , String receiverId) async{
    var timeSend = DateTime.now().toUtc().toIso8601String();

    final messageRef =
    _database.child('users/$senderId/chats/$receiverId/messages').push();
    final messageObj = {
      'text': message,
      'senderId': senderId,
      "timeSend": timeSend,
    };
    await messageRef.set(messageObj);
    _database
        .child('users/$receiverId/chats/$senderId/messages')
        .push()
        .set(messageObj);
  }

}