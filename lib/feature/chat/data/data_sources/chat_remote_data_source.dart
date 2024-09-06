abstract class ChatRemoteDataSource{

  Future<void> sendMessage(String message , String senderId , String receiverId);
}