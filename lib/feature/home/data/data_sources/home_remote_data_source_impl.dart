import 'package:educatly_task/core/api/api_consumer.dart';
import 'package:educatly_task/core/api/end_points.dart';
import 'package:educatly_task/feature/home/data/data_sources/home_remote_data_source.dart';
import 'package:educatly_task/feature/home/data/models/home_model.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource{
  ApiConsumer consumer;


  HomeRemoteDataSourceImpl({required this.consumer});

  @override
  Future<List<HomeModel>> getAllUsers() async{
    final res = await consumer.get(EndPoints.users);
    return List<HomeModel>.from(res.map((item) => HomeModel.fromJson(item)));
  }

}