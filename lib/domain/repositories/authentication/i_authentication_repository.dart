import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IAuthenticationRepository {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> addUser(
      {required String email, required String name, required String idAdmin});

  Future<void> signOut();

  Stream<User?> getCurrentUser();

  Future<String> getCurrentUserName();

  User? getSignedInUser();

  Future<String> getCurrentUserRole();
}
