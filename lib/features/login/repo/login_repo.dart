import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/features/login/model/login_response_model.dart';

class LoginRepo {
  final DioHelper dioHelper;
  LoginRepo(this.dioHelper);

  Future<Either<String, LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioHelper.postRequest(
        endpoint: ApiEndpoints.login,
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
          response.data,
        );
        if (loginResponseModel.accessToken != null) {
          final decodedToken = JwtDecoder.decode(
            loginResponseModel.accessToken!,
          );
          log(
            '📅 Token Expiry: ${JwtDecoder.getExpirationDate(loginResponseModel.accessToken!)}',
          );
          log('🎭 Token Claims: $decodedToken');

          await sl<StorageHelper>().saveData(
            key: StorageKeys.accessToken,
            value: loginResponseModel.accessToken!,
          );
          await sl<StorageHelper>().saveData(
            key: StorageKeys.role,
            value: loginResponseModel.role!,
          );
          await sl<StorageHelper>().saveData(
            key: StorageKeys.userId,
            value: loginResponseModel.userId!,
          );
          await sl<StorageHelper>().saveData(
            key: StorageKeys.refreshToken,
            value: loginResponseModel.refreshToken!,
          );

          final String name = decodedToken["name"];
          await sl<StorageHelper>().saveData(
            key: StorageKeys.name,
            value: name.toString(),
          );

          await sl<StorageHelper>().saveData(
            key: StorageKeys.name,
            value: decodedToken["name"],
          );

          return right(loginResponseModel);
        } else {
          return left("token is null");
        }
      } else {
        return left(response.toString());
      }
    } catch (error) {
      if (error is DioException) {
        return left(error.response.toString());
      }
      return left(error.toString());
    }
  }
}
