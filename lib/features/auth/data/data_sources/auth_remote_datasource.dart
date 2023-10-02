import 'dart:async';

import 'package:dio/dio.dart';
import 'package:inbloc_clean/core/errors/failures.dart';
import 'package:inbloc_clean/features/auth/data/models/login_user_response_model.dart';

import '../../../../../core/utils/constants/app_url.dart';
import '../../../../core/errors/modals/error_response_modal.dart';
import '../../../../core/utils/constants/app_messages.dart';
import '../models/login_user_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginUserResponseModel> loginUser(LoginUserRequestModel params);
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  Dio dio;
  AuthRemoteDataSourceImp({required this.dio});

  @override
  Future<LoginUserResponseModel> loginUser(LoginUserRequestModel params) async {
    String url = AppUrl.loginUrl;

    try {
      final response = await dio.post(url, data: params.toJson());

      if (response.statusCode == 200) {
        if (response.data['code'] != 1) {
          var object = LoginUserResponseModel.fromJson(response.data);

          return object;
        } else {
          throw SomethingWentWrong(response.data['message']);
        }
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel.fromJson(exception.response?.data);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }
}
