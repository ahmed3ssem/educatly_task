import 'package:dio/dio.dart';
import 'package:educatly_task/feature/home/data/data_sources/home_remote_data_source.dart';
import 'package:educatly_task/feature/home/data/data_sources/home_remote_data_source_impl.dart';
import 'package:educatly_task/feature/home/data/repositories/home_repository_impl.dart';
import 'package:educatly_task/feature/home/domain/repositories/home_repository.dart';
import 'package:educatly_task/feature/home/domain/use_cases/home_usecase.dart';
import 'package:educatly_task/feature/home/presentation/cubit/home_cubit.dart';
import 'package:educatly_task/feature/login/data/data_sources/login_remote_datasource.dart';
import 'package:educatly_task/feature/login/data/data_sources/login_remote_datasource_impl.dart';
import 'package:educatly_task/feature/login/data/repositories/login_repository_impl.dart';
import 'package:educatly_task/feature/login/domain/repositories/login_repository.dart';
import 'package:educatly_task/feature/login/domain/use_cases/login_usecase.dart';
import 'package:educatly_task/feature/login/presentation/cubit/login_cubit.dart';
import 'package:educatly_task/feature/signup/data/data_sources/signup_remote_datasource.dart';
import 'package:educatly_task/feature/signup/data/data_sources/signup_remote_datasource_impl.dart';
import 'package:educatly_task/feature/signup/data/repositories/signup_repository_impl.dart';
import 'package:educatly_task/feature/signup/domain/repositories/signup_repository.dart';
import 'package:educatly_task/feature/signup/domain/use_cases/signup_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptor.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';
import 'feature/signup/presentation/cubit/signup_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async{

  //Blocs
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory(() => SignupCubit(signUpUseCase: sl()));
  sl.registerFactory(() => HomeCubit(homeUseCase: sl()));

  //UseCase
  sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(signUpRepository: sl()));
  sl.registerLazySingleton(() => HomeUseCase(homeRepository: sl()));

  //Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(loginRemoteDataSource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImpl(signUpRemoteDatasource: sl() , networkInfo: sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(homeRemoteDataSource: sl() , networkInfo: sl()));

  //DataSource
  sl.registerLazySingleton<LoginRemoteDatasource>(() => LoginRemoteDatasourceImpl());
  sl.registerLazySingleton<SignUpRemoteDatasource>(() => SignUpRemoteDatasourceImpl());
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(consumer: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));


  //External
  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppInterceptor());
  sl.registerLazySingleton(() => Dio());
}