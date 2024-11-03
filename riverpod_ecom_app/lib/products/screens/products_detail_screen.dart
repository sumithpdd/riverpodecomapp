import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/products/repos/products_repo.dart';

import '../models/products.dart';

class ProductsDetailScreen extends ConsumerWidget {
  const ProductsDetailScreen({required this.product, super.key});
  final Products product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title!),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(product.images!.first.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.description!),
            ),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(productsRepoProvider)
                      .addProductToCart(product: product)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product added to cart'),
                      ),
                    );
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error adding product to cart'),
                      ),
                    );
                  });
                },
                child: Text('Add to cart \$${product.price}')),
          ],
        ));
  }
}
