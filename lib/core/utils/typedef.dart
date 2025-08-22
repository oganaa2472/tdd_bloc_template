import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

typedef ResultFuture<Type> = Future<Either<Failure,Type>>;


typedef ResultVoid = ResultFuture<void>;

typedef DataMap = Map<String,dynamic>;