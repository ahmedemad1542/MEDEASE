import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';

class DeleteAdvertisementRepo {
  final DioHelper _dioHelper;
  DeleteAdvertisementRepo(this._dioHelper);

  Future<Either<String, dynamic>> deleteAdvertisement({
    required String id,
  }) async {
    try {
      final response = await _dioHelper.deleteRequest(
        endpoint: ApiEndpoints.deleteAdvertisement(id),
      );
      if (response.statusCode == 200) {
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
