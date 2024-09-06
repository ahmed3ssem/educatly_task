abstract class ChatRemoteDataSource{

  Future<void> sendMessage(String message , String senderId , String receiverId);

  Future<String> reveiveMessage();

  Future<List<Map<String, dynamic>>> getChatHistory(String receiverId);
}