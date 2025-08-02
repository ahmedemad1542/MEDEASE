import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/features/patients/model/patients_model.dart';


class PatientsRepo {
  final DioHelper dioHelper;

  PatientsRepo(this.dioHelper);

  Future<Map<String, dynamic>> getPatients({required int page}) async {
    try {
      final response = await dioHelper.getResponse(
        endpoint: ApiEndpoints.getPatients,
        query: {"page": page},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;
        final List<dynamic> PatientsData =
            jsonData['patients'] as List<dynamic>? ?? [];
        final Patients =
            PatientsData.map((json) => PatientModel.fromJson(json)).toList();
        final totalPages = jsonData['totalPages'] as int? ?? 1;
        return {'Patients': Patients, 'totalPages': totalPages};
      } else if (response.statusCode == 404) {
        return {'Patients': [], 'totalPages': 0};
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> deletePatient({required String id}) async {
    try {
      final response = await dioHelper.deleteRequest(
        endpoint: ApiEndpoints.deletePatient(id),
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
