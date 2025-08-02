import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/features/advertisements/getAdvertisement/model/advertisements_model.dart';

class AdvertisementsRepo {
  final DioHelper dioHelper;

  AdvertisementsRepo(this.dioHelper);

  Future<Map<String, dynamic>> getAdvertisements({required int page}) async {
    try {
      final response = await dioHelper.getResponse(
        endpoint: ApiEndpoints.getAdvertisements,
        query: {"page": page},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;
        final List<dynamic> advertisementsData =
            jsonData['data'] as List<dynamic>? ?? [];
        final advertisements =
            advertisementsData
                .map((json) => AdvertisementsModel.fromJson(json))
                .toList();
        final totalPages = jsonData['totalPages'] as int? ?? 1;
        return {'advertisements': advertisements, 'totalPages': totalPages};
      } else if (response.statusCode == 404) {
        return {'advertisements': [], 'totalPages': 0};
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // update advertisment
  Future<bool> updateAdvertisement({
    required String id,
    required String title,
    required String description,
  }) async {
    try {
      final response = await dioHelper.patchRequest(
        endpoint: '${ApiEndpoints.getAdvertisements}/$id',
        data: {'title': title, 'description': description},
        isFormData: true,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update advertisement');
      }
      return response.data['success'] as bool? ?? false;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
