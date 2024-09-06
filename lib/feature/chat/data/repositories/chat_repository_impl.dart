import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/exceptions.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/network/network_info.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/feature/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:educatly_task/feature/chat/domain/repositories/chat_repository.dart';
import 'package:get/get.dart';

class ChatRepositoryImpl extends ChatRepository {

  final NetworkInfo networkInfo;
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl({required this.networkInfo ,required this.chatRemoteDataSource});

  @override
  Future<Either<Failures, NoParams>> sendMessage(String senderId , String receiverId , String message) async{
    if(await networkInfo.isConnected){
      try{
        final response = await chatRemoteDataSource.sendMessage(message, senderId , receiverId);
        return Right(NoParams());
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

  @override
  Future<Either<Failures , List<Map<String, dynamic>>>> getChatHistory(String receiverId) async{
    if(await networkInfo.isConnected){
      try{
        final response = await chatRemoteDataSource.getChatHistory(receiverId);
        return Right(response);
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }
}
