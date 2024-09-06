import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/feature/chat/domain/repositories/chat_repository.dart';

class ChatHistoryUseCase implements UseCase<List<Map<String, dynamic>> , ChatParams>{

  final ChatRepository chatRepository;
  ChatHistoryUseCase({required this.chatRepository});

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> call(ChatParams params) => chatRepository.getChatHistory(params.receiverId);

}