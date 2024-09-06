part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeInitial{}

class HomeIsLoading extends HomeInitial{}

class HomeLoaded extends HomeInitial{

  List<HomeModel> homeModel;

  HomeLoaded({required this.homeModel});

  @override
  List<Object> get props => [homeModel];
}

class HomeError extends HomeInitial{
  final String msg;
  HomeError({required this.msg});

  @override
  List<Object> get props =>[msg];
}
