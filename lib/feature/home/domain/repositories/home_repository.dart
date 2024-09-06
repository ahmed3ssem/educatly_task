import 'package:dartz/dartz.dart';
import 'package:educatly_task/core/error/failures.dart';
import 'package:educatly_task/feature/home/data/models/home_model.dart';

abstract class HomeRepository {

  Future<Either<Failures , List<HomeModel>>> getUserInfo();
}
