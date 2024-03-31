part of 'add_products_bloc.dart';

@immutable
sealed class AddProductsState {}

final class AddProductsInitial extends AddProductsState {
  final String imagePath;
  final bool isLoading;
  AddProductsInitial({
    required this.imagePath,
    required this.isLoading,
  });
}

final class AddProductLoading extends AddProductsState {}
