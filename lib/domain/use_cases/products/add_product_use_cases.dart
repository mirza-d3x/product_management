import '../../entities/products/products.dart';
import '../../repositories/products/product_repo.dart';

class AddProductUseCase {
  final ProductRepository _productRepository;

  AddProductUseCase(this._productRepository);

  Future<void> call(Product product) async {
    return await _productRepository.addProduct(product);
  }
}
