import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/core/utils/my_logger.dart';
import 'package:medease1/features/Diagnosis/model/diagnosis_model.dart';

class DiagnosisRepo {
  final DioHelper dio;
  DiagnosisRepo(this.dio);

  Future<void> addDiagnosis(Map<String, dynamic> body) async {
    await dio.postRequest(endpoint: '/diagnosis/', data: body);
  }

  Future<List<DiagnosisModel>> getAllDiagnoses(String doctorId) async {
    final response = await dio.getResponse(
      endpoint: '/diagnosis/$doctorId/all',
    );

    final List data = response.data['diagnoses'] ?? [];
    return data.map((e) => DiagnosisModel.fromJson(e)).toList();
  }

  Future<DiagnosisModel> getSpecificDiagnosis(
    String diagnosisId,
    String relatedId,
  ) async {
    final response = await dio.getResponse(
      endpoint: '/diagnosis/$diagnosisId/$relatedId',
    );
    return DiagnosisModel.fromJson(response.data);
  }

  Future<void> updateDiagnosis(
    String diagnosisId,
    String medicationId,
    List<String> medications,
  ) async {
    await dio.patchRequest(
      endpoint: '/diagnosis/$diagnosisId/$medicationId',
      data: {'medications': medications},
    );
  }

  Future<void> deleteDiagnosis(String id) async {
    await dio.deleteRequest(endpoint: '/diagnosis/$id');
  }
}
