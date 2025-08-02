import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/features/register/model/register_model.dart';

class RegisterRepo {
  final DioHelper _dioHelper;
  RegisterRepo(this._dioHelper);

  Future<Either<String, dynamic>> register({
    required RegisterResponseModel registerModel,
    required String gender,
    required String dateOfBirth,
  }) async {
    try {
      final response = await _dioHelper.postRequest(
        endpoint: ApiEndpoints.register,
        data: {
          "name": registerModel.name,
          "email": registerModel.email,
          "password": registerModel.password,
          "phone": registerModel.phone,
          "city": registerModel.city,
          "country": registerModel.country,
          "gender": gender,
          "dateOfBirth": dateOfBirth,
        },
      );
      if (response.statusCode == 201) {
        return right(response.data);
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
