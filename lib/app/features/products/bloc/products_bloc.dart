import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:techwarelab/utils/console_log.dart';

import '../../../../domain/entities/products/products.dart';
import '../../../../domain/use_cases/products/fetch_product_use_cases.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final FetchProductsUseCase _fetchProductsUseCase;

  ProductsBloc(this._fetchProductsUseCase) : super(ProductsInitial()) {
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
}
