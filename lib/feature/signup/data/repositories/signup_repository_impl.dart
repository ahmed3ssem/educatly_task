import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/exceptions.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/network/network_info.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/feature/signup/data/data_sources/signup_remote_datasource.dart';
import 'package:educatly_task/feature/signup/domain/repositories/signup_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpRepositoryImpl extends SignUpRepository {

	final NetworkInfo networkInfo;
  final SignUpRemoteDatasource signUpRemoteDatasource;

  SignUpRepositoryImpl({required this.networkInfo ,required this.signUpRemoteDatasource});

  @override
  Future<Either<Failures, NoParams>> signup(String email, String password , BuildContext context) async{
    if(await networkInfo.isConnected){
      try{
        final response = await signUpRemoteDatasource.signup(email, password , context);
        return Right(NoParams());
      } on ServerException{
        return Left(ServerFailure(msg: 'error'.tr));
      }
    } else {
      return Left(CashFailure(msg: 'connectionError'.tr));
    }
  }
}
