import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/utils/my_logger.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/storage/storage_helper.dart';
// import 'package:medease1/core/networking/api_interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  DioHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio!.interceptors.add(PrettyDioLogger());
    dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await sl<StorageHelper>().getData(
            key: StorageKeys.accessToken,
          );

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            options.headers['cookie'] = "accessToken=$token";
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          MyLogger.red('Dio Error: ${error.response?.data}');

          if (error.response?.data['message'].toLowerCase().contains('token')) {
            MyLogger.red('Access token expired or invalid');
            sl<StorageHelper>().deleteData(key: "accesstoken");
            final refreshToken = await sl<StorageHelper>().getData(
              key: StorageKeys.refreshToken,
            );

            // RefreshToken
            try {
              if (refreshToken == null || refreshToken.isEmpty) {
                throw Exception('No refresh token available.');
              }

              // Create a separate, clean Dio instance for the refresh call
              final refreshDio = Dio();
              final response = await refreshDio.post(
                '${ApiEndpoints.baseUrl}${ApiEndpoints.refreshToken}',
                options: Options(
                  headers: {
                    // This correctly sends the refresh token as a cookie
                    'cookie': 'refreshToken=$refreshToken',
                  },
                ),
              );

              if (response.statusCode == 200 || response.statusCode == 201) {
                //  Save the new token
                final newAccessToken = response.data['accessToken'];
                await sl<StorageHelper>().saveData(
                  key: StorageKeys.accessToken,
                  value: newAccessToken,
                );
                MyLogger.green('Token refreshed successfully.');

                // Retry the original request with the new token
                final originalRequestOptions = error.requestOptions;
                originalRequestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';
                originalRequestOptions.headers['cookie'] =
                    "accessToken=$newAccessToken";

                final retryResponse = await dio!.fetch(originalRequestOptions);
                return handler.resolve(retryResponse); // Complete the request
              }
            } catch (e) {
              //TODO: Logout when refreshToken fails
              MyLogger.red('Error refreshing access token: $e');
            }
          } else {
            MyLogger.red('Dio Error: ${error.message}');
          }
          return handler.next(error);
        },
      ),
    );
  }

  getResponse({required String endpoint, Map<String, dynamic>? query}) async {
    try {
      Response response = await dio!.get(endpoint, queryParameters: query);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  postRequest({
    required String endpoint,
    required Map<String, dynamic> data,
    bool isFormData = false,
  }) async {
    try {
      Response response = await dio!.post(
        endpoint,
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  deleteRequest({required String endpoint}) async {
    try {
      Response response = await dio!.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Patch
  patchRequest({
    required String endpoint,
    required Map<String, dynamic> data,
    bool isFormData = false,
  }) async {
    try {
      Response response = await dio!.patch(
        endpoint,
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Put
  putRequest({
    required String endpoint,
    required Map<String, dynamic> data,
    bool isFormData = false,
  }) async {
    try {
      Response response = await dio!.put(
        endpoint,
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  // Post
}
