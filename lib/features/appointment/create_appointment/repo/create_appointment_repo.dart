import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';

class AppointmentRepo {
  final DioHelper _dioHelper;
  AppointmentRepo(this._dioHelper);

  Future<Either<String, dynamic>> createAppointment({
    required String id,
    required String priority,
    required String appointmentDate,
    required String status,
  }) async {
    try {
      final response = await _dioHelper.postRequest(
        endpoint: ApiEndpoints.createAppointment(id),
        data: {
          "priority": priority,
          "appointmentDate": appointmentDate,
          "status": status,
        },
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
