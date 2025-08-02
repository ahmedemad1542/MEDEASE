/*import 'package:dartz/dartz.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/features/products/model/products_model.dart';

class ProductsRepo {
  final DioHelper _dioHelper = DioHelper();
  //singelton

  static final ProductsRepo _instance = ProductsRepo._internal();
  factory ProductsRepo() => _instance;
  ProductsRepo._internal();

  ProductsModel? productslist;

  Future<Either<String, List<ProductsModel>>> getProducts() async {
    try {
      final response = await _dioHelper.getResponse(
        endpoint: ApiEndpoints.getProducts,
      );
      if (response.statusCode == 200) {
        final List<dynamic> productJson = response.data['products'];
        final products = productJson.map((e) => ProductsModel.fromJson(e)).toList();
        return right(products);
      } else {
        return left('Error: ${response.statusCode}');
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
*/