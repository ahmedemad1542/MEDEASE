/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/products/repo/products_repo.dart';

import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final productsrepo = ProductsRepo();
  

  ProductsCubit() : super(ProductsInitial());
  void getProducts() async {
    emit(ProductsLoading());
    final response = await productsrepo.getProducts();
    response.fold((error) => emit(ProductsError(error)), (products) => emit(ProductsLoaded(products)));
  }
}*/
