import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../repository/auth_repostory.dart';

class CacheUserUsecase {
  const CacheUserUsecase(this.repository);
  final AuthRepository repository;
  Future<Either<Failure, void>> call(CacheUserParams params) async {
    return await repository.cacheUserData(
        name: params.name, email: params.email);
  }
}

class CacheUserParams extends Equatable {
  const CacheUserParams({required this.name, required this.email});

  const CacheUserParams.emptyUserParameters()
      : this(
          name: 'empty.name',
          email: 'empty.email',
        );

  final String name;
  final String email;

  @override
  List<Object?> get props => [name, email];
}
