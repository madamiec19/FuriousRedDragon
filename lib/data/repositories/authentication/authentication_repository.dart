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
      {required String email,
      required String password,
      required String name}) async {
    final response = await _supabaseAuth.signUp(
      password: password,
      email: email,
      emailRedirectTo: _redirectUrl,
    );
    print(response.user!.id);
    await _supabaseDb.from('roles').insert([
      {
        'user_id': response.user!.id,
        'name': name,
        'status': 'admin',
        'email': email,
      }
    ]);
  }

  @override
  Future<String> getCurrentUserName() async {
    try {
      var response = await _supabaseDb
          .from('roles')
          .select('name')
          .eq('user_id', _supabaseAuth.currentUser!.id)
          .single();
      return response['name'] as String;
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

  @override
  Future<String> getCurrentUserRole() async {
    try {
      var response = await _supabaseDb
          .from('roles')
          .select('status')
          .eq('user_id', _supabaseAuth.currentUser!.id)
          .single();
      return response['status'] as String;
    } catch (error) {
      print(error.toString());
    }
    return '';
  }

  @override
  Future<int> getCurrentUserId() async {
    try {
      final response = await _supabaseDb
          .from('roles')
          .select('id')
          .eq('user_id', _supabaseAuth.currentUser!.id)
          .single();
      return response['id'] as int;
    } catch (error) {
      print(error.toString());
    }
    return -1;
  }

  @override
  Future<void> addUser(
      {required String email,
      required String name,
      required String password,
      required int idAdmin}) async {
    try {
      final data =
          await _supabaseDb.from('roles').select('email').eq('email', email);
      final count = data.length;
      if (count == 0) {
        await _supabaseAuth.admin.createUser(AdminUserAttributes(
            email: email, password: password, emailConfirm: true));
      }

      final list = await _supabaseAuth.admin.listUsers();
      final user = list.firstWhere((user) => user.email == email);
      final userId = user.id;

      await _supabaseDb.from('roles').insert({
        'user_id': userId,
        'name': name,
        'status': 'pracownik',
        'email': email,
        'id_admin': idAdmin
      });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<void> verifyWithToken(String token, String email) async {
    await _supabaseAuth.verifyOTP(
        token: token, type: OtpType.signup, email: email);
  }
}
