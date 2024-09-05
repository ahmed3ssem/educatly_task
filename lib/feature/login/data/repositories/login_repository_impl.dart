import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/exceptions.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/network/network_info.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_sources/login_remote_datasource.dart';

class LoginRepositoryImpl extends LoginRepository {

	final NetworkInfo networkInfo;
  final LoginRemoteDatasource loginRemoteDataSource;

	LoginRepositoryImpl({required this.networkInfo ,required this.loginRemoteDataSource});

  @override
  Future<Either<Failures, NoParams>> login(String email, String password , BuildContext context) async{
    if(await networkInfo.isConnected){
      try{
        final response = await loginRemoteDataSource.login(email, password , context);
        return Right(NoParams());
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }
}
