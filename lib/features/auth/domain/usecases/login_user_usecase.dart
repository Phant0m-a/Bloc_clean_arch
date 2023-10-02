import 'package:dartz/dartz.dart';
import 'package:inbloc_clean/features/auth/data/models/login_user_request_model.dart';
import 'package:inbloc_clean/features/auth/data/models/login_user_response_model.dart';
import 'package:inbloc_clean/features/auth/domain/repository/auth_repostory.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class LoginUsecase
    extends Usecase<LoginUserResponseModel, LoginUserRequestModel> {
  AuthRepository repository;
  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, LoginUserResponseModel>> call(
      LoginUserRequestModel params) async {
    return await repository.loginUser(params);
  }
}
