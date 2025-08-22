
import 'package:equatable/equatable.dart' show Equatable;
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

abstract class AuthState extends Equatable{
  const AuthState();
  @override
  List<Object?> get props => [];
}


class AuthInitial extends AuthState{
  const AuthInitial();
}
class GreatingUser extends AuthState {
  const GreatingUser();
}
class GettingUser extends AuthState {
  const GettingUser();
}

class UserCreated extends AuthState {
  const UserCreated();
}
class UsersLoaded extends AuthState {
  const UsersLoaded(this.users);
  final List<User> users;
  @override
  List<Object?> get props => users.map((user)=>user.id).toList();
}
class AuthError extends AuthState{
  final String message;
  const AuthError(this.message);
  @override
  List<String> get props => [message];
}