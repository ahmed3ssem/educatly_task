import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:flutter/material.dart';

abstract class LoginRepository {

  Future<Either<Failures , NoParams>> login(String email , String password , BuildContext context);
}
