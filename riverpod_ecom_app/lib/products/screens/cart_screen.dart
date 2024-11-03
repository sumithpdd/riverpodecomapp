import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/products/models/products.dart';
import 'package:riverpod_ecom_app/products/repos/products_repo.dart';

import '../providers/cart_screen_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Products>> cartItems = ref.watch(cartStreamProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart Screen'),
        ),
        body: cartItems.when(data: (cartList) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(cartList[index].thumbnail.toString()),
                title: Text(cartList[index].title!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cartList[index].description!),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '\$${cartList[index].price.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                trailing: IconButton(
                    onPressed: () {
                      ref
                          .read(productsRepoProvider)
                          .removeItemFromCart(id: cartList[index].id!)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product removed from cart'),
                          ),
                        );
                      });
                    },
                    icon: Icon(Icons.delete, color: Colors.red[400])),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: cartList.length,
          );
        }, error: (err, stk) {
          return Center(child: Text('Error : $err'));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }));
  }
}
