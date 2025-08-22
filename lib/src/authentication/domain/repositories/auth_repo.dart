import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

abstract class AuthRepo{
  const AuthRepo();
  // either means that return left or right 
  ResultVoid createUser({
    required String name,required String avatar,required String createdAt
  });
  ResultFuture<List<User>> getUsers();  
}