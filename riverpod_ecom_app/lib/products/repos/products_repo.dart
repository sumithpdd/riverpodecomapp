import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/networking/dio_client.dart';

import '../../firebase_constants.dart';
import '../models/products.dart';
import '../../networking/api_endpoints.dart';

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

  Future addProductToCart({required Products product}) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(userId)
          .collection(FirebaseConstants.cartCollection)
          .add(product.toJson());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Stream<List<Products>> getCartProducts() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(user.uid)
          .collection(FirebaseConstants.cartCollection)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Products.fromJson(doc.data());
        }).toList();
      });
    } else {
      return Stream.error('Error fetching cart items');
    }
  }

  Future removeItemFromCart({required int id}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(user.uid)
          .collection(FirebaseConstants.cartCollection)
          .where('id', isEqualTo: id)
          .get();
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } else {
      return Future.error('Error removing item from cart');
    }
  }
}

final productsRepoProvider = Provider<ProductsRepo>((ref) => ProductsRepo(ref));
