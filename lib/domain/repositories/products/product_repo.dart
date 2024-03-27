import '../../entities/products/products.dart';

abstract class ProductRepository {
  Future<void> addProduct(Product product);
  Future<List<Product>> getAllProducts();
}
