import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techwarelab/utils/console_log.dart';

import '../../../../domain/entities/products/products.dart';
import '../../../../domain/repositories/products/product_repo.dart';

class FirebaseProductRepository implements ProductRepository {
  FirebaseProductRepository() {
    init();
  }

  late FirebaseFirestore _firestore;
  late final CollectionReference<Map<String, dynamic>> _productsCollection;

  void init() {
    _firestore = FirebaseFirestore.instance;
    _productsCollection = _firestore.collection('products');
  }

  @override
  Future<void> addProduct(Product product) async {
    try {
      await _productsCollection.add(product.toJson());

      await _productsCollection.doc(product.name).set(product.toJson());
    } catch (error) {
      consoleLog("Failed to add product: ", error: error);

      throw Exception('Failed to add product: $error');
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _productsCollection
              .get(const GetOptions(source: Source.serverAndCache));
      consoleLog("response: ${snapshot.docChanges}");
      if (snapshot.docs.isEmpty) {
        return [];
      } else {
        return snapshot.docs
            .map((doc) => Product.fromJson(doc.data()))
            .toList();
      }
    } catch (erorr, stacktrace) {
      consoleLog("Error getting all products",
          error: erorr, stackTrace: stacktrace);
      throw Exception('Failed to fetch products: $erorr');
    }
  }
}
