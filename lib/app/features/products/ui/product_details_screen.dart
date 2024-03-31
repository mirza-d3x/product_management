import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:techwarelab/domain/entities/products/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: size.height * .35,
                        width: size.width,
                        child: QrImageView(
                          data: product.toJson().toString(),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.qr_code),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Image.network(product.imageUrl),
              const SizedBox(height: 24),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Price: ${product.price}",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50.h,
          color: const Color(0XFF2381AA),
          child: TextButton(
              onPressed: () {},
              child: const Text(
                "Remove Product",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )),
        ),
      ),
    );
  }
}
