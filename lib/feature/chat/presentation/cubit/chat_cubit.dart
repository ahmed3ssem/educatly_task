import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:educatly_task/feature/chat/domain/use_cases/chat_history_usecase.dart';
import 'package:educatly_task/feature/chat/domain/use_cases/chat_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {

  final ChatUseCase chatUseCase;
  final ChatHistoryUseCase chatHistoryUseCase;
  ChatCubit({required this.chatUseCase , required this.chatHistoryUseCase}) : super(ChatInitial());

  void initLoginPage() => emit(ChatInitial());


  Future<void> sendMessage(String senderId , String receiverId , String message) async{
    Either<Failures , NoParams> response = await chatUseCase(ChatParams(receiverId: receiverId, senderId: senderId , message: message));
    emit(response.fold(
            (failures) => ChatError(msg: failures.msg),
            (noParams) => ChatSendMessageLoaded()));
  }

  Future<void> getChatHistory(String receiverId) async{
    emit(ChatIsLoading());
    Either<Failures , List<Map<String, dynamic>>> response = await chatHistoryUseCase(ChatParams(receiverId: receiverId , message: '' , senderId: ''));
    emit(response.fold(
            (failures) => ChatError(msg: failures.msg),
            (history) => ChatHistoryLoaded(chatHistory: history)));
  }


  String mapFailureToMsg(Failures failures){
    switch (failures.runtimeType){
      case const (ServerFailure):
        return AppStrings.serverError;
      case const (CashFailure):
        return AppStrings.cacheError;
      default:
        return AppStrings.unexpectedError;
    }
  }
}
