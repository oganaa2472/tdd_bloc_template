

import 'package:bloc/bloc.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

   AuthCubit({
    required CreateUser createUser,
    required GetUsers getUser,
}):_createUser = createUser,
    _getUsers = getUser,
  super(AuthInitial());
  final CreateUser _createUser;
  final GetUsers _getUsers;

   Future<void> createUser ({required name,required avatar,required createdAt}) async {
    emit(const GreatingUser());
    final result = await _createUser(CreateUserParams(name:name, avatar: avatar, createdAt: createdAt));
    result.fold((failure)=> emit(AuthError('${failure.statusCode} '
    'Error: ${failure.message}')),(_)=>emit(const UserCreated()));
  }
  Future<void> getUsers () async {

    final result = await _getUsers();
    result.fold((failure)=> emit(AuthError('${failure.errorMessage}')),(users)=> emit(UsersLoaded(users)),);
  }
  
}