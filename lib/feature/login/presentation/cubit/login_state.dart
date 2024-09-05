part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginInitial{}

class LoginIsLoading extends LoginInitial{}

class LoginLoaded extends LoginInitial{}

class LoginError extends LoginInitial{
  final String msg;
  LoginError({required this.msg});

  @override
  List<Object> get props =>[msg];
}