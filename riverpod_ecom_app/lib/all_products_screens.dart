import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/products.dart';
import 'providers/products_future_provider.dart';

class AllProductsScreens extends ConsumerWidget {
  const AllProductsScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Products>> products =
        ref.watch(productsFutureProvider);
    final AsyncValue<List<String>> categories =
        ref.watch(categoryFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal ListView for categories
          categories.when(
            data: (data) {
              return SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black26,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            data[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            error: (error, stk) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(height: 10),
          // Expanded vertical ListView for products
          Expanded(
            child: products.when(
              data: (data) {
                return ListView.separated(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(data[index].thumbnail.toString()),
                      title: Text(data[index].title!),
                      subtitle: Text(data[index].description!),
                      trailing: Text('\$${data[index].price.toString()}'),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              },
              error: (error, stk) => Text(error.toString()),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
