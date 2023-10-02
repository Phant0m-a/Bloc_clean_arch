
//create type def
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final statusCode;

  final errorMessage;

  const Failure({this.statusCode, this.errorMessage});

  @override
  List<Object?> get props => [statusCode, errorMessage];

}

class LocalFailure extends Failure{

}

typedef FutureResult<T> = Future<Either<Failure, T>>;

typedef Futurevoid = FutureResult<void>;