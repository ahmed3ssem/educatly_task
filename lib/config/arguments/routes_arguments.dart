class RoutesArgument{}

class ChatArguments extends RoutesArgument{

  final String receiverId;
  final String email;

  ChatArguments({required this.receiverId , required this.email});
}
