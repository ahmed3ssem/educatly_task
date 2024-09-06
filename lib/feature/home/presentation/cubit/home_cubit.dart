import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:educatly_task/feature/home/data/models/home_model.dart';
import 'package:educatly_task/feature/home/domain/use_cases/home_usecase.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase homeUseCase;
  HomeCubit({required this.homeUseCase }) : super(HomeInitial());

  void initHomePage() => emit(HomeInitial());


  Future<void> getAllUsers() async{
    emit(HomeIsLoading());
    Either<Failures , List<HomeModel>> response = await homeUseCase(NoParams());
    emit(response.fold(
            (failures) => HomeError(msg: failures.msg),
            (home) => HomeLoaded(homeModel: home)));
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
