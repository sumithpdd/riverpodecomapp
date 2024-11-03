import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repo/auth_repo.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

extension AuthStatusX on AuthStatus {
  bool get isLoading => this == AuthStatus.loading;
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isError => this == AuthStatus.error;
}

final authProvider =
    NotifierProvider<AuthProvider, AuthStatus>(() => AuthProvider());

class AuthProvider extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    return AuthStatus.initial;
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      state = AuthStatus.loading;
      final user = await ref
          .read(authRepoProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        state = AuthStatus.authenticated;
      }
    } catch (e) {
      log(e.toString());
      state = AuthStatus.error;
    }
  }

  Future createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      state = AuthStatus.loading;
      final user = await ref
          .read(authRepoProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        state = AuthStatus.authenticated;
      }
    } catch (e) {
      log(e.toString());
      state = AuthStatus.error;
    }
  }

  void logout() {
    state = AuthStatus.unauthenticated;
  }

  void error() {
    state = AuthStatus.error;
  }

  void signOut() {}
}
