import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/auth_repo.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';

class CreateUser extends UsecaseWithParams<void,CreateUserParams>{
  const CreateUser(this.authRepo);
  final AuthRepo authRepo;
  @override
  ResultFuture call(CreateUserParams params) => authRepo.createUser(name: params.name, avatar: params.avatar, createdAt: params.createdAt);

  registerLazySingleton(GetUsers Function() param0) {}
} 

class CreateUserParams extends Equatable{
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams({required this.name,required this.avatar,required this.createdAt});
  
  @override
  List<Object?> get props => [name,avatar,createdAt];  
}