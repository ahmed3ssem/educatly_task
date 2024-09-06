part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatInitialState extends ChatInitial{}

class ChatIsLoading extends ChatInitial{}

class ChatSendMessageLoaded extends ChatInitial{}

class ChatHistoryLoaded extends ChatInitial{

  final List<Map<String, dynamic>> chatHistory;
  ChatHistoryLoaded({required this.chatHistory});

  @override
  List<Object> get props =>[chatHistory];
}

class ChatError extends ChatInitial{
  final String msg;
  ChatError({required this.msg});

  @override
  List<Object> get props =>[msg];
}