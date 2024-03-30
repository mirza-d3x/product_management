import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techwarelab/app/features/products/bloc/products_bloc.dart';

import '../../../../domain/entities/products/products.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            final List<Product> products = state.products;
            if (products.isEmpty) {
              return Container(
                height: size.height,
                width: size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("No Products Found"),
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Add Products"),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Icon(Icons.add),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          }
          return Container(
            alignment: Alignment.center,
            height: size.height,
            width: size.width,
            child: const Text("Products"),
          );
        },
      ),
    );
  }
}
