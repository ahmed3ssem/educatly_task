import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:educatly_task/feature/signup/domain/use_cases/signup_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {

  final SignUpUseCase signUpUseCase;
  SignupCubit({required this.signUpUseCase }) : super(SignupInitial());

  void initLoginPage() => emit(SignupInitial());


  Future<void> signup(String email , String password , BuildContext context) async{
    emit(SignUpIsLoading());
    Either<Failures , NoParams> response = await signUpUseCase(LoginParams(email: email, password: password , context: context));
    emit(response.fold(
            (failures) => SignUpError(msg: failures.msg),
            (login) => SignUpLoaded()));
  }


  String mapFailureToMsg(Failures failures){
    switch (failures.runtimeType){
      case const (ServerFailure):
        return AppStrings.serverError;
      case const (CashFailure):
        return AppStrings.cacheError;
      default:
        return AppStrings.unexpectedError;
    }
  }
}


