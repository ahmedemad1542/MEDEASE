import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/features/doctors/model/doctors_model.dart';

class DoctorsRepo {
  final DioHelper dioHelper;

  DoctorsRepo(this.dioHelper);

  Future<Map<String, dynamic>> getDoctors({required int page}) async {
    try {
      final response = await dioHelper.getResponse(
        endpoint: ApiEndpoints.getDoctors,
        query: {"page": page},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;
        final List<dynamic> doctorsData =
            jsonData['data'] as List<dynamic>? ?? [];
        final doctors =
            doctorsData.map((json) => DoctorsModel.fromJson(json)).toList();
        final totalPages = jsonData['totalPages'] as int? ?? 1;
        return {'doctors': doctors, 'totalPages': totalPages};
      } else if (response.statusCode == 404) {
        return {'doctors': [], 'totalPages': 0};
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> deleteDoctor({required String id}) async {
    try {
      final response = await dioHelper.deleteRequest(
        endpoint: ApiEndpoints.deleteDoctor(id),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete doctor');
      }
      return true;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  
}
