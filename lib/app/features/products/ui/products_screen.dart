import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techwarelab/app/features/authentication/cubit/auth_cubit.dart';
import 'package:techwarelab/app/features/products/bloc/products_bloc.dart';
import 'package:techwarelab/app/features/products/ui/product_details_screen.dart';
import 'package:techwarelab/app/features/products/widgets/product_card.dart';
import 'package:techwarelab/app/widgets/custom_textfield.dart';
import 'package:techwarelab/services/navigation_services/navigation_services.dart';

import '../../../../domain/entities/products/products.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Timer? searchLatencyTimer;

  @override
  void initState() {
    searchLatencyTimer = Timer(const Duration(microseconds: 0), () {});
    super.initState();
  }

  static bool isLoading = false;

  @override
  void dispose() {
    if (searchLatencyTimer != null) {
      searchLatencyTimer!.cancel();
    }
    searchLatencyTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          isLoading = true;
        } else if (state is UserLoggedOut) {
          isLoading = false;
          context.navigationService.createLoginPageRoute(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<AuthenticationCubit>(context).logOutUser();
            },
            icon: const Icon(Icons.logout),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.navigationService.createAddProductsPageRoute(context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                    label: "Search Products",
                    hint: "Search",
                    controller: TextEditingController(),
                    obscureText: false,
                    onChanged: (value) {
                      searchLatencyTimer!.cancel();
                      if (value.length > 2) {
                        searchLatencyTimer = Timer(
                          const Duration(milliseconds: 500),
                          () {
                            BlocProvider.of<ProductsBloc>(context).add(
                              SearchProductFromList(query: value),
                            );
                          },
                        );
                      }
                    }),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ProductLoaded) {
                      final List<Product> products = state.products;
                      if (products.isEmpty) {
                        return Column(
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
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
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
                                          builder: (context) =>
                                              ProductDetailsScreen(
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
                            ],
                          ),
                        );
                      }
                    }
                    return const Text("Products");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
