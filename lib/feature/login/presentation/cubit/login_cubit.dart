import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:educatly_task/feature/login/domain/use_cases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final LoginUseCase loginUseCase;
  LoginCubit({required this.loginUseCase }) : super(LoginInitial());

  void initLoginPage() => emit(LoginInitial());


  Future<void> login(String email , String password , BuildContext context) async{
    emit(LoginIsLoading());
    Either<Failures , NoParams> response = await loginUseCase(LoginParams(email: email, password: password , context: context));
    emit(response.fold(
            (failures) => LoginError(msg: failures.msg),
            (login) => LoginLoaded()));
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
