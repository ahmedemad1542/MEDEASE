import 'package:dio/dio.dart';
import 'treatment_model.dart';

class TreatmentRepo {
  final Dio dio;
  TreatmentRepo(this.dio);

  Future<List<TreatmentModel>> getTreatmentsByDisease(String diseaseId) async {
    final response = await dio.get("/treatments/");
    final List data = response.data["data"];
    return data
        .where((item) => item["diseaseID"] == diseaseId)
        .map((e) => TreatmentModel.fromJson(e))
        .toList();
  }

  Future<void> createTreatment(Map<String, dynamic> data) async {
    await dio.post("/treatments/", data: data);
  }

  Future<void> updateTreatment(String id, Map<String, dynamic> data) async {
    await dio.patch("/treatments/$id", data: data);
  }
}
