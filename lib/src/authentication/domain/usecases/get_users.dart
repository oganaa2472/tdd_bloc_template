import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/auth_repo.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final AuthRepo authRepo;
  const GetUsers(this.authRepo);
  @override
  ResultFuture<List<User>> call() => authRepo.getUsers();
} 