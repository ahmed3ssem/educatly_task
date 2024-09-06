import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';

abstract class ChatRepository {

  Future<Either<Failures , NoParams>> sendMessage(String senderId , String receiverId , String message);

  Future<Either<Failures , List<Map<String, dynamic>>>> getChatHistory(String receiverId);
}
