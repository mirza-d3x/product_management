import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwarelab/app/features/add_products/bloc/add_products_bloc.dart';
import 'package:techwarelab/app/features/products/bloc/products_bloc.dart';
import 'package:techwarelab/domain/use_cases/file_storage/file_upload_use_cases.dart';
import 'package:techwarelab/services/cloud_services/firebase/firebase_storage/firebase_storage_services.dart';
import '../../../../domain/use_cases/products/add_product_use_cases.dart';
import '../../../../domain/use_cases/products/fetch_product_use_cases.dart';
import '../../../../services/cloud_services/firebase/firestore/firestore_services.dart';
import 'add_products_screen.dart';

class AddProductsRouteBuilder {
  Widget call(BuildContext context) {
    final FirebaseProductRepository productRepository =
        FirebaseProductRepository();
    final FirebaseStorageService firebaseStorageService =
        FirebaseStorageService();
    return BlocProvider(
      create: (context) => AddProductsBloc(AddProductUseCase(productRepository),
          UploadFileUseCase(firebaseStorageService)),
      child: const AddProductsScreen(),
    );
  }
}
