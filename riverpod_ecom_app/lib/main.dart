import 'package:flutter/material.dart';
import 'package:riverpod_ecom_app/all_products_screens.dart';

import 'counter_screen.dart';

void main() {
  runApp(RiverpodEcommApp());
}

class RiverpodEcommApp extends MaterialApp {
  RiverpodEcommApp({super.key}) : super(home: CounterScreen());
}
