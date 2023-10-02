import 'package:dartz/dartz.dart';
import 'package:inbloc_clean/core/errors/failures.dart';
import 'package:inbloc_clean/features/auth/data/models/cache_data_response_modal.dart';
import 'package:inbloc_clean/features/auth/data/models/login_user_response_model.dart';

import '../../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/network_info/network_info.dart';
import '../../domain/repository/auth_repostory.dart';
import '../data_sources/auth_local_datasource.dart';
import '../data_sources/auth_remote_datasource.dart';
import '../models/login_user_request_model.dart';

class AuthRepoImp extends AuthRepository {
  final NetworkInfo networkInfo;

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepoImp({
    required this.localDataSource,
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginUserResponseModel>> loginUser(
      LoginUserRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.loginUser(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> cacheUserData(
      {required String name, required String email}) async {
    try {
      final result =
          await localDataSource.cacheUserData(name: name, email: email);
      return Right(result);
    } on Failure catch (e) {
      return Left((e));
    }
  }

  @override
  Future<Either<Failure, CachedUser>> getCachedUser() async {
    try {
      final result = await localDataSource.getCachedUser();
      return Right(result);
    } on Failure catch (e) {
      return Left((e));
    }
  }

  @override
  Future<Either<Failure, void>> logOutUser() async {
    try {
      final result = await localDataSource.logoutUser();
      return Right(result);
    } on Failure catch (e) {
      return Left((e));
    }
  }
}
