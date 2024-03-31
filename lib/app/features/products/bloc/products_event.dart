part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class FetchProductsEvent extends ProductsEvent {}

class SearchProductFromList extends ProductsEvent {
  final String query;

  SearchProductFromList({required this.query});
}
