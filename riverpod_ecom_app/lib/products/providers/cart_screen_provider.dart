import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/products/repos/products_repo.dart';

import '../models/products.dart';

final cartStreamProvider = StreamProvider.autoDispose<List<Products>>((ref) {
  return ref.watch(productsRepoProvider).getCartProducts();
});
