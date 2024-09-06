import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/core/usecase/use_case.dart';
import 'package:educatly_task/feature/home/data/models/home_model.dart';
import 'package:educatly_task/feature/home/domain/repositories/home_repository.dart';

class HomeUseCase implements UseCase<List<HomeModel> , NoParams>{

  final HomeRepository homeRepository;
  HomeUseCase({required this.homeRepository});

  @override
  Future<Either<Failures, List<HomeModel>>> call(NoParams params) => homeRepository.getUserInfo();

}