import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/feature/signup/domain/repositories/signup_repository.dart';

class SignUpUseCase implements UseCase<NoParams , LoginParams>{

  final SignUpRepository signUpRepository;
  SignUpUseCase({required this.signUpRepository});

  @override
  Future<Either<Failures, NoParams>> call(LoginParams params) => signUpRepository.signup(params.email, params.password , params.context);
  
}