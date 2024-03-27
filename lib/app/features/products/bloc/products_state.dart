part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductLoading extends ProductsState {}

final class ProductLoaded extends ProductsState {
  final List<Product> products;

  ProductLoaded({required this.products});
}

final class ProductLoadingFailed extends ProductsState {}

final class ProductError extends ProductsState {
  final String error;

  ProductError({required this.error});
}
