// import 'package:dio/dio.dart';
// import 'package:medease1/core/utils/storage_helper.dart';

// class ApiInterceptors extends Interceptor {
//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     options.headers['token'] =
//         'Bearer ${await StorageHelper().getData(key: "accesstoken")}';
//     super.onRequest(options, handler);
//   }
// }
