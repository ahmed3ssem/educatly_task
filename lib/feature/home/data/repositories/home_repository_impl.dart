import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/exceptions.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/network/network_info.dart';
import 'package:educatly_task/feature/home/data/data_sources/home_remote_data_source.dart';
import 'package:educatly_task/feature/home/data/models/home_model.dart';
import 'package:educatly_task/feature/home/domain/repositories/home_repository.dart';
import 'package:get/get.dart';


class HomeRepositoryImpl extends HomeRepository {

  final NetworkInfo networkInfo;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl({required this.networkInfo ,required this.homeRemoteDataSource});

  @override
  Future<Either<Failures, List<HomeModel>>> getUserInfo() async{
    if(await networkInfo.isConnected){
      try{
        final response = await homeRemoteDataSource.getAllUsers();
        if(response.isNotEmpty){
          return Right(response);
        } else {
          return Left(ServerFailure(msg: 'error'.tr));
        }
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }

}
