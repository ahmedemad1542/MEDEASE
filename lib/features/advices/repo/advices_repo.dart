import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/features/advices/model/advices_model.dart';
import 'package:medease1/features/advices/model/category_model.dart';
import '../../../core/networking/dio_helper.dart';

class AdviceRepo {
  final DioHelper dioHelper;
  AdviceRepo(this.dioHelper);

  Future<Response?> getAllAdvices() async {
    return await dioHelper.getResponse(endpoint: ApiEndpoints.getAllAdvices);
  }

  Future<Response?> createAdvice({
    required String diseasesCategoryId,
    required String title,
    required String description,
    required String doctorId,
  }) async {
    return await dioHelper.postRequest(
      endpoint: ApiEndpoints.createAdvice,
      data: {
        "diseasesCategoryId": diseasesCategoryId,
        "title": title,
        'description': description,
        'doctorId': doctorId,
      },
      isFormData: true,
    );
  }

  Future<Response?> updateAdvice({
    required String adviceId,
    required String diseasesCategoryId,
    required String title,
    required String description,
  }) async {
    return await dioHelper.patchRequest(
      endpoint: '${ApiEndpoints.updateAdvice}$adviceId',
      data: {
        "diseasesCategoryId": diseasesCategoryId,
        "title": title,
        "description": description,
      },
    );
  }

  Future<Response?> deleteAdvice(String adviceId) async {
    return await dioHelper.deleteRequest(
      endpoint: '${ApiEndpoints.deleteAdvice}$adviceId',
    );
  }

  Future<Response?> createLike(String adviceId) async {
    return await DioHelper.dio!.post(
      '${ApiEndpoints.likeAdvice}$adviceId/like',
    );
  }

  Future<Response?> createDislike(String adviceId) async {
    return await DioHelper.dio!.post(
      '${ApiEndpoints.dislikeAdvice}$adviceId/dislike',
    );
  }

  Future<List<CategoryModel>?> getCategories() async {
    try {
      final response = await dioHelper.getResponse(
        endpoint: ApiEndpoints.getCategories,
      );

      if (response != null && response.statusCode == 200) {
        // 1. Access the list from the 'data' key in the response.
        final List<dynamic> dataList = response.data['data'];

        // 2. Map the raw list into a typed List<Category>.
        final List<CategoryModel> categories =
            dataList
                .map(
                  (item) =>
                      CategoryModel.fromJson(item as Map<String, dynamic>),
                )
                .toList();

        // 3. Return the parsed list.
        return categories;
      }
    } catch (e) {
      log('Error fetching and parsing categories: $e');
    }

    // Return null if anything goes wrong.
    return null;
  }
}
