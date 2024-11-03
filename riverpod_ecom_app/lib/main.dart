import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/products/screens/all_products_screens.dart';
import 'package:riverpod_ecom_app/auth/screen/login_screen.dart';
import 'package:riverpod_ecom_app/firebase_options.dart';

import 'counter_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
    child: RiverpodEcommApp(),
  ));
}

class RiverpodEcommApp extends MaterialApp {
  RiverpodEcommApp({super.key}) : super(home: LoginScreen());
  //const AllProductsScreens()); //CounterScreen());
}
