class Message {
  final String senderId;
  final String messageId;
  final String message;
  final int timestamp;

  Message({
    required this.senderId,
    required this.messageId,
    required this.message,
    required this.timestamp,
  });

  // Factory method to create a Message instance from a Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      messageId: map['messageId'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as int,
    );
  }

  // Convert Message instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'messageId': messageId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
