import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/networking/dio_client.dart';

import '../models/products.dart';
import '../networking/api_endpoints.dart';

class ProductsRepo {
  final Ref ref;
  ProductsRepo(this.ref);

  Future<List<Products>> getProducts() async {
    final response =
        await ref.read(dioProvider).get(ApiEndpoints.GetProductsEndPoint);
    if (response.statusCode == 200) {
      List<Products> products = response.data['products']
          .map<Products>((product) => Products.fromJson(product))
          .toList();
      return products;
    } else {
      return Future.error('Failed to load products');
    }
  }

  Future<List<String>> getCategories() async {
    final response =
        await ref.read(dioProvider).get(ApiEndpoints.GetCategoryListEndPoint);
    if (response.statusCode == 200) {
      List<String> categories = (response.data as List<dynamic>)
          .map((category) => category.toString())
          .toList();
      return categories;
    } else {
      return Future.error('Failed to load categories');
    }
  }
}

final productsRepoProvider = Provider<ProductsRepo>((ref) => ProductsRepo(ref));
