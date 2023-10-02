import 'dart:convert';
import 'package:inbloc_clean/core/errors/failures.dart';
import 'package:inbloc_clean/core/utils/constants/app_local_storage_keys.dart';
import 'package:inbloc_clean/features/auth/data/models/cache_data_response_modal.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUserData({required String name, required String email});
  Future<CachedUser> getCachedUser();
  Future<void> logoutUser();
}

class AuthLocalDataSrcImpl extends AuthLocalDataSource {
  AuthLocalDataSrcImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<void> cacheUserData(
      {required String name, required String email}) async {
    try {
      String user = jsonEncode({
        'data': {'Name': name, 'Email': email}
      });
      final response = await sharedPreferences.setString(
          AppLocalStorageKeys.kUserDataKey, user);

      if (response != true) {
        throw const LocalException(
            message: 'Data is not saved', statusCode: 400);
      }
    } catch (e) {
      throw LocalException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<CachedUser> getCachedUser() async {
    try {
      final response =
          sharedPreferences.getString(AppLocalStorageKeys.kUserDataKey);
      if (response == null || response == '') {
        throw const SomethingWentWrong('Error occurred while getting User');
      } else {
        return CachedUser.fromJson(jsonDecode(response)['data']);
      }
    } catch (e) {
      throw LocalException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      final response =
          await sharedPreferences.remove(AppLocalStorageKeys.kUserDataKey);
      if (response != true) {
        throw const LocalException(
            message: 'Error occurred while removing User', statusCode: 500);
      }
    } on LocalException {
      rethrow;
    } catch (e) {
      throw LocalException(message: e.toString(), statusCode: 505);
    }
  }
}
