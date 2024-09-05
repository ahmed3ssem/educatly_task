part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class SignUpInitialState extends SignupInitial{}

class SignUpIsLoading extends SignupInitial{}

class SignUpLoaded extends SignupInitial{}

class SignUpError extends SignupInitial{
  final String msg;
  SignUpError({required this.msg});

  @override
  List<Object> get props =>[msg];
}