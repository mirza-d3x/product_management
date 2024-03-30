import 'package:bloc/bloc.dart';
import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';
import 'package:techwarelab/utils/console_log.dart';

import '../../../../domain/entities/products/products.dart';
import '../../../../domain/use_cases/products/add_product_use_cases.dart';
import '../../../../domain/use_cases/products/fetch_product_use_cases.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final AddProductUseCase _addProductUseCase;
  final FetchProductsUseCase _fetchProductsUseCase;

  ProductsBloc(this._addProductUseCase, this._fetchProductsUseCase)
      : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchProductsEvent>(_onFetchProducts);
    add(FetchProductsEvent());
  }
  void _onFetchProducts(
      FetchProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductLoading());
    try {
      final products = await _fetchProductsUseCase();
      consoleLog("Products: $products");
      emit(ProductLoaded(products: products));
    } catch (error, stackTrace) {
      consoleLog("Failed to Fetch Products: ",
          error: error, stackTrace: stackTrace);
      emit(ProductError(error: error.toString()));
    }
  }

  void _onAddProduct(
      AddProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductLoading());
    try {
      final products = await _fetchProductsUseCase();
      consoleLog("Products: $products");
      emit(ProductLoaded(products: products));
    } catch (error, stackTrace) {
      consoleLog("Failed to Fetch Products: ",
          error: error, stackTrace: stackTrace);
      emit(ProductError(error: error.toString()));
    }
  }
}
