import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient client;

  AuthService(this.client);

  Future<void> signInUser(String userEmail, String password) async {
    try {
      await client.auth.signInWithPassword(
        email: userEmail,
        password: password,
      );
    } on AuthException catch (authError) {
      print('Błąd logowania: $authError');
      return;
    }
  }

  /// nie wiem do czego to, może potem sie przyda
  // StreamSubscription<AuthState> listenToAuthStatus() {
  //   return client.auth.onAuthStateChange.listen((data) {
  //     final Session? session = data.session;
  //     final AuthChangeEvent event = data.event;
  //     switch (event) {
  //       default:
  //         break;
  //     }
  //   });
  // }

  String? getEmail() {
    return client.auth.currentUser!.email;
  }

  bool isLoggedIn() {
    return client.auth.currentSession != null;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
