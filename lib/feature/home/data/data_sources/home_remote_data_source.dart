import 'package:educatly_task/feature/home/data/models/home_model.dart';

abstract class HomeRemoteDataSource{

  Future<List<HomeModel>> getAllUsers();
}