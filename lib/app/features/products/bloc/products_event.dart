part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class FetchProductsEvent extends ProductsEvent {
  // @override
  // List<Product> get props => [];
}

class AddProductsEvent extends ProductsEvent {
  final Product product;

  AddProductsEvent({required this.product});
}
