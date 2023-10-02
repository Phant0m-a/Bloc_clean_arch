import 'package:dartz/dartz.dart';
import 'package:inbloc_clean/core/errors/failures.dart';
import 'package:inbloc_clean/features/auth/data/models/cache_data_response_modal.dart';

import '../repository/auth_repostory.dart';

class GetCachedUserUsecase {
  const GetCachedUserUsecase({required this.repository});

  final AuthRepository repository;

  Future<Either<Failure, CachedUser>> call() async {
    return await repository.getCachedUser();
  }
}
