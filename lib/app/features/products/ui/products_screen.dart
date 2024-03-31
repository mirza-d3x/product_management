import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techwarelab/app/features/products/bloc/products_bloc.dart';
import 'package:techwarelab/app/features/products/ui/product_details_screen.dart';
import 'package:techwarelab/app/features/products/widgets/product_card.dart';
import 'package:techwarelab/services/navigation_services/navigation_services.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              context.navigationService.createAddProductsPageRoute(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
                      onPressed: () {
                        context.navigationService
                            .createAddProductsPageRoute(context);
                      },
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
              return Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: .8,
                    crossAxisSpacing: 8.h,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              product: products[index],
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        image: state.products[index].imageUrl,
                        price: state.products[index].price,
                        title: state.products[index].name,
                      ),
                    );
                  },
                ),
              );
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
