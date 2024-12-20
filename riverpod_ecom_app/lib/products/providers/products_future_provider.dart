import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/products/models/products.dart';
import 'package:riverpod_ecom_app/products/repos/products_repo.dart';

final productsFutureProvider = FutureProvider<List<Products>>((ref) async {
  return await ref.watch(productsRepoProvider).getProducts();
});
final categoryFutureProvider = FutureProvider<List<String>>((ref) async {
  return await ref.watch(productsRepoProvider).getCategories();
});
