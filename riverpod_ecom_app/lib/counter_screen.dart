import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'counter_provider.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(counter.toString()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).increment();
                  },
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).decrement();
                  },
                  child: const Text('Remove'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).reset();
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     ref.read(counterProvider.notifier).increment();
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
