import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthStatus> {
  final IAuthenticationRepository _authenticationRepository;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc(this._authenticationRepository) : super(AuthInitial()) {
    on<AuthInitialCheckRequested>(_onInitialAuthChecked);
    on<AuthLogoutButtonPressed>(_onLogoutButtonPressed);
    on<AuthOnCurrentUserChanged>(_onCurrentUserChanged);
    on<AuthAdminUserAdding>(_onAdminAddingUser);
    _startUserSubscription();
  }

  Future<void> _onAdminAddingUser(
      AuthAdminUserAdding event, Emitter<AuthStatus> emit) async {
    await _authenticationRepository.addUser(
        email: event.email,
        name: event.name,
        password: event.password,
        idAdmin: await _authenticationRepository.getCurrentUserId());
  }

  Future<void> _onInitialAuthChecked(
      AuthInitialCheckRequested event, Emitter<AuthStatus> emit) async {
    User? signedInUser = _authenticationRepository.getSignedInUser();

    signedInUser != null
        ? emit(AuthUserAuthenticated(signedInUser, '',
            await _authenticationRepository.getCurrentUserId()))
        : emit(AuthUserUnauthenticated());
  }

  Future<void> _onLogoutButtonPressed(
      AuthLogoutButtonPressed event, Emitter<AuthStatus> emit) async {
    emit(AuthInitial());
    await _authenticationRepository.signOut();
  }

  Future<void> _onCurrentUserChanged(
      AuthOnCurrentUserChanged event, Emitter<AuthStatus> emit) async {
    String? signedInUserName =
        await _authenticationRepository.getCurrentUserName();
    event.user != null
        ? emit(AuthUserAuthenticated(event.user!, signedInUserName,
            await _authenticationRepository.getCurrentUserId()))
        : emit(AuthUserUnauthenticated());
  }

  void _startUserSubscription() => _userSubscription = _authenticationRepository
      .getCurrentUser()
      .listen((user) => add(AuthOnCurrentUserChanged(user)));

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

abstract class AuthEvent {}

class AuthInitialCheckRequested extends AuthEvent {}

class AuthOnCurrentUserChanged extends AuthEvent {
  final User? user;
  AuthOnCurrentUserChanged(this.user);
}

class AuthLogoutButtonPressed extends AuthEvent {}

class AuthAdminUserAdding extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthAdminUserAdding(this.name, this.email, this.password);
}

abstract class AuthStatus {}

class AuthInitial extends AuthStatus {}

class AuthUserAuthenticated extends AuthStatus {
  final User user;
  final String userName;
  final int userId;

  AuthUserAuthenticated(this.user, this.userName, this.userId);
}

class AuthUserUnauthenticated extends AuthStatus {}
