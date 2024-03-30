import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwarelab/app/features/products/bloc/products_bloc.dart';
import 'package:techwarelab/app/features/products/ui/add_products_screen.dart';

import '../../../../domain/use_cases/products/add_product_use_cases.dart';
import '../../../../domain/use_cases/products/fetch_product_use_cases.dart';
import '../../../../services/cloud_services/firebase/firestore/firestore_services.dart';

class AddProductsRouteBuilder {
  Widget call(BuildContext context) {
    final FirebaseProductRepository productRepository =
        FirebaseProductRepository();
    return BlocProvider(
      create: (context) => ProductsBloc(
        AddProductUseCase(productRepository),
        FetchProductsUseCase(productRepository),
      ),
      child: const AddProductsScreen(),
    );
  }
}
