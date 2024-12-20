import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterProvider extends StateNotifier<int> {
  CounterProvider() : super(0);

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }

  void reset() {
    state = 0;
  }
}

final counterProvider =
    StateNotifierProvider<CounterProvider, int>((ref) => CounterProvider());
