part of 'add_products_bloc.dart';

@immutable
sealed class AddProductsEvent {}

class AddImageEvent extends AddProductsEvent {}

class AddProductEvent extends AddProductsEvent {}
