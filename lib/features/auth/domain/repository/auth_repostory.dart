import 'package:dartz/dartz.dart';
import 'package:inbloc_clean/core/errors/failures.dart';
import 'package:inbloc_clean/features/auth/data/models/login_user_request_model.dart';
import 'package:inbloc_clean/features/auth/data/models/login_user_response_model.dart';

import '../../data/models/cache_data_response_modal.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginUserResponseModel>> loginUser(
      LoginUserRequestModel params);

  Future<Either<Failure, void>> logOutUser();

  Future<Either<Failure, void>> cacheUserData(
      {required String name, required String email});
  Future<Either<Failure, CachedUser>> getCachedUser();
}
