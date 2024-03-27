part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class FetchProductsEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}
