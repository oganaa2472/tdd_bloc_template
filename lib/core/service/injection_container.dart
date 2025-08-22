import 'package:get_it/get_it.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/repo/auth_repo_impl.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/auth_repo.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/auth_cubit.dart';
import 'package:http/http.dart' as http;
final sl = GetIt.instance;

Future<void> init() async {
  // api logic
sl
  ..registerFactory(
    () => AuthCubit(
      createUser: sl(),
      getUser: sl(),
    ),
  )
  // use cases
  ..registerLazySingleton(() => CreateUser(sl()))
  ..registerLazySingleton(() => GetUsers(sl()))

  // repos
  ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
  // datasources
  ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSrcImpl(sl()))

      // external dependencies
  ..registerLazySingleton(() => http.Client());




}