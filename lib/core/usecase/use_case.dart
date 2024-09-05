import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:flutter/cupertino.dart';

abstract class UseCase<Type, Params> {

  Future<Either<Failures , Type>> call(Params params);
}


class NoParams extends Equatable{

  @override
  List<Object?> get props => [];
}

class LoginParams extends Equatable{

  final String email;
  final String password;
  final BuildContext context;

  const LoginParams({required this.email,required this.password , required this.context});
  @override
  List<Object?> get props => [email , password , context];
}
