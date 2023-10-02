import 'package:dartz/dartz.dart';
import 'package:inbloc_clean/core/errors/failures.dart';

import '../repository/auth_repostory.dart';

class LogoutUserUsecase {
  const LogoutUserUsecase(this.repository);
  final AuthRepository repository;
  Future<Either<Failure, void>> call() async {
    return await repository.logOutUser();
  }
}
