import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwarelab/app/features/authentication/cubit/auth_cubit.dart';
import 'package:techwarelab/app/features/products/bloc/products_bloc.dart';
import 'package:techwarelab/app/features/products/ui/products_screen.dart';
import 'package:techwarelab/domain/use_cases/products/fetch_product_use_cases.dart';
import 'package:techwarelab/domain/use_cases/user/login_use_case.dart';
import 'package:techwarelab/domain/use_cases/user/signup_use_cases.dart';
import 'package:techwarelab/services/cloud_services/firebase/authentication/auth_services.dart';
import '../../../../services/cloud_services/firebase/firestore/firestore_services.dart';

class ProductsRouteBuilder {
  Widget call(BuildContext context) {
    final FirebaseProductRepository productRepository =
        FirebaseProductRepository();
    final FirebaseAuthServices authRepository = FirebaseAuthServices();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsBloc(
            FetchProductsUseCase(productRepository),
          ),
        ),
        BlocProvider(
          create: (context) => AuthenticationCubit(
            LoginUserUseCase(authRepository),
            SignUpUserUseCase(authRepository),
          ),
        ),
      ],
      child: ProductsScreen(),
    );
  }
}
