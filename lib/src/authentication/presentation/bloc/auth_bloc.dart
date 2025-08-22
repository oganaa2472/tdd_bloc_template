
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/bloc/auth_event.dart';
import 'package:tdd_tutorial/src/authentication/presentation/bloc/auth_state.dart';
class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc({
    required CreateUser createUser,
    required GetUsers getUser,
}):_createUser = createUser,
    _getUsers = getUser,
  super(AuthInitial()){
    on<CreateUserEvent>(_createUserHandler);
     on<GetUserEvent>(_getUserHandler);
  }
  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler (event,emit) async {
    emit(const GreatingUser());
    final result = await _createUser(CreateUserParams(name: event.name, avatar: event.avatar, createdAt: event.createdAt));
    result.fold((failure)=> emit(AuthError('${failure.statusCode} '
    'Error: ${failure.message}')),(_)=>emit(const UserCreated()));
  }
  Future<void> _getUserHandler (event,emit) async {
    emit(const GetUserEvent());
    final result = await _getUsers();
    result.fold((failure)=> emit(AuthError('${failure.errorMessage}')),(users)=> emit(UsersLoaded(users)),);
  }
}