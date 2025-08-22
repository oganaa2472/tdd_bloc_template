import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo{
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepoImpl(this.remoteDataSource);
  
  @override
  ResultVoid createUser({required String name, required String avatar, required String createdAt}) async {
    // dependency injection 
   
    try{
       await remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt);
       return Right(null);
    }  catch(e){
      return Left(ApiFailure(message: e.toString(),statusCode: 400));
    }

  }

  @override
  ResultFuture<List<User>> getUsers() async {
     try{
        final users = await remoteDataSource.getUsers();
       return Right(users);
    }  catch(e){
      return Left(ApiFailure(message: e.toString(),statusCode: 400));
    }
    
  }

}
