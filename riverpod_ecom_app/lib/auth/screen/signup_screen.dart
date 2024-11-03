import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/products/screens/all_products_screens.dart';
import 'package:riverpod_ecom_app/auth/screen/login_screen.dart';
import 'package:riverpod_ecom_app/extensions/build_context_extensions.dart';

import '../provider/auth_provider.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next.isAuthenticated) {
        context.goTo(const AllProductsScreens(), replace: true);
      } else if (next.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error Login'),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      return;
                    }
                    ref
                        .read(authProvider.notifier)
                        .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);
                  },
                  child: ref.watch(authProvider).isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
                ),
                TextButton(
                    onPressed: () {
                      context.goBack();
                    },
                    child: const Text('Already have an account? Login')),
              ],
            )),
      ),
    );
  }
}
