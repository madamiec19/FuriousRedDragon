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

    _startUserSubscription();
  }

  Future<void> _onInitialAuthChecked(
      AuthInitialCheckRequested event, Emitter<AuthStatus> emit) async {
    User? signedInUser = _authenticationRepository.getSignedInUser();
    signedInUser != null
        ? emit(AuthUserAuthenticated(signedInUser))
        : emit(AuthUserUnauthenticated());
  }

  Future<void> _onLogoutButtonPressed(
      AuthLogoutButtonPressed event, Emitter<AuthStatus> emit) async {
    await _authenticationRepository.signOut();
  }

  Future<void> _onCurrentUserChanged(
          AuthOnCurrentUserChanged event, Emitter<AuthStatus> emit) async =>
      event.user != null
          ? emit(AuthUserAuthenticated(event.user!))
          : emit(AuthUserUnauthenticated());

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

abstract class AuthStatus {}

class AuthInitial extends AuthStatus {}

class AuthUserAuthenticated extends AuthStatus {
  final User user;

  AuthUserAuthenticated(this.user);
}

class AuthUserUnauthenticated extends AuthStatus {}
