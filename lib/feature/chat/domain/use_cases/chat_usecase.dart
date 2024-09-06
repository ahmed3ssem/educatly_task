import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/feature/chat/domain/repositories/chat_repository.dart';

class ChatUseCase implements UseCase<NoParams , ChatParams>{

  final ChatRepository chatRepository;
  ChatUseCase({required this.chatRepository});

  @override
  Future<Either<Failures, NoParams>> call(ChatParams params) => chatRepository.sendMessage(params.senderId, params.receiverId , params.message);



}