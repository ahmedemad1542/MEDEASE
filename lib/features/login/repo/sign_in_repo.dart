// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:medease1/core/networking/api_endpoints.dart';
// import 'package:medease1/core/networking/dio_helper.dart';
// import 'package:medease1/core/utils/storage_helper.dart';

// import 'package:medease1/features/login/model/login_response_model.dart';

// class SignInRepo {
//   final DioHelper dioHelper;
//   SignInRepo(this.dioHelper);
//   Future<Either<String, LoginResponseModel>> signIn({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await dioHelper.postRequest(
//         data: {'username': email, 'password': password},
//         endpoint: ApiEndpoints.login,
//       );

//       final LoginResponseModel user = LoginResponseModel.fromJson(response);
//       final decodedToken = JwtDecoder.decode(user.accessToken!);
//       final id = decodedToken['_id'];
//       StorageHelper().saveData(key: '_id', value: id.toString());
//       StorageHelper().saveData(key: 'accesstoken', value: user.accessToken!);
//       return Right(user);
//     } on DioException catch (e) {
//       return Left(e.message ?? "An error occurred");
//     }
//   }
// }
