import '../../entities/products/products.dart';
import '../../repositories/products/product_repo.dart';

class FetchProductsUseCase {
  final ProductRepository _productRepository;

  FetchProductsUseCase(this._productRepository);

  Future<List<Product>> call() async {
    return await _productRepository.getAllProducts();
  }
}
