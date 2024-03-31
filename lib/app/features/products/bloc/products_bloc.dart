import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:techwarelab/utils/console_log.dart';

import '../../../../domain/entities/products/products.dart';
import '../../../../domain/use_cases/products/fetch_product_use_cases.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final FetchProductsUseCase _fetchProductsUseCase;
  late final TextEditingController _searchTextController;

  List<Product> products = [];

  ProductsBloc(this._fetchProductsUseCase) : super(ProductsInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<SearchProductFromList>(_onSearchProductFromList);
    init();
  }

  void init() {
    _searchTextController = TextEditingController();
    add(FetchProductsEvent());
  }

  void _onFetchProducts(
      FetchProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductLoading());
    try {
      products = await _fetchProductsUseCase();
      consoleLog("Products: $products");
      emit(ProductLoaded(products: products));
    } catch (error, stackTrace) {
      consoleLog("Failed to Fetch Products: ",
          error: error, stackTrace: stackTrace);
      emit(ProductError(error: error.toString()));
    }
  }

  void _onSearchProductFromList(
      SearchProductFromList event, Emitter<ProductsState> emit) {
    if (products.isNotEmpty) {
      if (event.query.isNotEmpty) {
        final filteredProducts = products
            .where((product) =>
                product.name.toLowerCase().contains(event.query.toLowerCase()))
            .toList();

        if (filteredProducts.isNotEmpty) {
          emit(ProductLoaded(products: filteredProducts));
        }
      } else {
        emit(ProductLoaded(products: products));
      }
    }
  }

  @override
  Future<void> close() {
    _searchTextController.dispose();
    products.clear();
    return super.close();
  }
}
