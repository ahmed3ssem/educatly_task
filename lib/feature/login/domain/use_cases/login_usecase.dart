import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';

import '../repositories/login_repository.dart';

class LoginUseCase implements UseCase<NoParams , LoginParams>{

  final LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failures, NoParams>> call(LoginParams params) => loginRepository.login(params.email, params.password , params.context);
  
}