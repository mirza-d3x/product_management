import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../domain/entities/products/products.dart';
import '../../../../domain/repositories/products/product_repo.dart';

class FirebaseProductRepository implements ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addProduct(Product product) async {
    // Code to add product to Firestore
  }

  @override
  Future<List<Product>> getAllProducts() async {
    // Code to fetch product data from Firestore
    throw UnimplementedError();
  }
}
