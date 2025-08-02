import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import '../../../core/networking/dio_helper.dart';
import '../model/user_model.dart';

class ProfileRepo {
  final DioHelper dioHelper;
  ProfileRepo(this.dioHelper);

  Future<Either<String, UserModel>> getUser() async {
    try {
      final token = await sl<StorageHelper>().getData(
        key: StorageKeys.accessToken,
      );
      log('🔐 Token used in ProfileRepo: $token');

      final response = await dioHelper.getResponse(
        endpoint: ApiEndpoints.getUser,
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);
        return right(user);
      } else {
        return left('Error: ${response.statusCode}');
      }
    } catch (error) {
      return left(error.toString());
    }
  }
}
