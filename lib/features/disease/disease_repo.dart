// import 'package:dio/dio.dart';
// import 'package:medease1/core/utils/storage_helper.dart';
// import 'disease_model.dart';

// class DiseaseRepo {
//   final Dio dio;
//   final StorageHelper storageHelper;
//   DiseaseRepo(this.dio, this.storageHelper);

//   Future<List<DiseaseModel>> getDiseases() async {
//     final response = await dio.get("/diseases/");

//     List data = response.data["data"] as List;
//     return data.map((e) => DiseaseModel.fromJson(e)).toList();
//   }
// }
// import 'package:dio/dio.dart';
// import 'package:medease1/core/utils/storage_helper.dart';
// import 'disease_model.dart';

// class DiseaseRepo {
//   final Dio dio;
//   DiseaseRepo(this.dio, StorageHelper storageHelper);

//   Future<List<DiseaseModel>> getDiseases() async {
//     final response = await dio.get("/diseases/");
//     List data = response.data["data"] as List;
//     return data.map((e) => DiseaseModel.fromJson(e)).toList();
//   }

//   Future<void> createDisease({
//     required String name,
//     required String description,
//     required String rank,
//     required String diseaseCategoryId,
//   }) async {
//     await dio.post(
//       "/diseases/",
//       data: {
//         "name": name,
//         "description": description,
//         "rank": rank,
//         "diseasecategoryId": diseaseCategoryId,
//       },
//     );
//   }

//   Future<void> updateDisease({
//     required String diseaseId,
//     required String name,
//     required String description,
//     required String rank,
//   }) async {
//     await dio.patch(
//       "/diseases/$diseaseId",
//       data: {"name": name, "description": description, "rank": rank},
//     );
//   }

//   Future<void> deleteDisease(String diseaseId) async {
//     await dio.delete("/diseases/$diseaseId");
//   }
// }

import 'package:dio/dio.dart';
import '../../core/storage/storage_helper.dart';
import 'disease_model.dart';

class DiseaseRepo {
  final Dio dio;
  DiseaseRepo(this.dio, StorageHelper storageHelper);

  Future<List<DiseaseModel>> getDiseases() async {
    final response = await dio.get("/diseases/");
    List data = response.data["data"] as List;
    return data.map((e) => DiseaseModel.fromJson(e)).toList();
  }

  Future<DiseaseModel> createDisease({
    required String name,
    required String description,
    required String rank,
    required String diseaseCategoryId,
  }) async {
    final response = await dio.post(
      "/diseases/",
      data: {
        "name": name,
        "description": description,
        "rank": rank,
        "diseasecategoryId": diseaseCategoryId,
      },
    );

    final json = response.data["data"];
    return DiseaseModel.fromJson(json);
  }

  Future<void> updateDisease({
    required String diseaseId,
    required String name,
    required String description,
    required String rank,
  }) async {
    await dio.patch(
      "/diseases/$diseaseId",
      data: {"name": name, "description": description, "rank": rank},
    );
  }

  Future<void> deleteDisease(String diseaseId) async {
    await dio.delete("/diseases/$diseaseId");
  }
}
