import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/features/appointment/all_appointment/model/appointment_model.dart';
import '../../../../core/networking/dio_helper.dart';

class GetAppointmentRepo {
  final DioHelper dioHelper;
  GetAppointmentRepo(this.dioHelper);

  Future<Either<String, List<AppointmentModel>>> getAppointment() async {
    try {
      final token = await sl<StorageHelper>().getData(
        key: StorageKeys.accessToken,
      );
      log('🔐 Token used in ProfileRepo: $token');

      final response = await dioHelper.getResponse(
        endpoint: ApiEndpoints.getAppointments,
        // headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final appointments =
            data.map((e) => AppointmentModel.fromJson(e)).toList();

        return right(appointments);
      } else {
        return left('Error: ${response.statusCode}');
      }
    } catch (error) {
      return left(error.toString());
    }
  }
}
