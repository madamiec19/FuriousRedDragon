import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IAuthenticationRepository)
class AuthenticationRepository implements IAuthenticationRepository {
  final GoTrueClient _supabaseAuth;
  final SupabaseClient _supabaseDb;
  static const String _redirectUrl =
      'io.supabase.flutterexample://signup-callback';

  AuthenticationRepository(this._supabaseAuth, this._supabaseDb);

  @override
  Stream<User?> getCurrentUser() =>
      _supabaseAuth.onAuthStateChange.map((event) => event.session?.user);

  @override
  User? getSignedInUser() => _supabaseAuth.currentUser;

  @override
  Future<void> signInWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _supabaseAuth.signInWithPassword(
        password: password,
        email: email,
      );

  @override
  Future<void> signOut() async => await _supabaseAuth.signOut();

  @override
  Future<void> signUpWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _supabaseAuth.signUp(
        password: password,
        email: email,
        emailRedirectTo: _redirectUrl,
      );

  @override
  Future<String> getCurrentUserName() async {
    var response = await _supabaseDb
        .from('roles')
        .select('name')
        .eq('user_id', _supabaseAuth.currentUser!.id)
        .single();
    return response['name'] as String;
  }

  @override
  Future<String> getCurrentUserRole() async {
    var response = await _supabaseDb
        .from('roles')
        .select('status')
        .eq('user_id', _supabaseAuth.currentUser!.id)
        .single();
    return response['status'] as String;
  }

  @override
  Future<int> getCurrentUserId() async {
    var response = await _supabaseDb
        .from('roles')
        .select('id')
        .eq('user_id', _supabaseAuth.currentUser!.id)
        .single();
    return response['id'] as int;
  }

  //TODO do przeniesienia do admin_bloc.dart
  @override
  Future<void> addUser(
      {required String email,
      required String name,
      required int idAdmin}) async {
    await _supabaseDb.from('roles').insert({
      'name': name,
      'status': 'pracownik',
      'email': email,
      'id_admin': idAdmin
    });

    await _supabaseAuth.admin.inviteUserByEmail(email);
  }
}
