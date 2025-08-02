/*import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/products/cubit/products_cubit.dart';
import 'package:medease1/features/products/repo/products_repo.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(ProductsRepo()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Products')),

        body: Builder(
          builder: (context) {
            return Container(
              height: 250,
              width: 170,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '15 stocks left',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Title'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
*/