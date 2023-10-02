import 'package:dartz/dartz.dart';
import 'package:inbloc_clean/core/errors/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
