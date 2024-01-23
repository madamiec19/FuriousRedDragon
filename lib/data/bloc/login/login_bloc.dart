import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/entities/email_address.dart';
import 'package:furious_red_dragon/domain/repositories/entities/password.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

/// Obsługa logowania
@Injectable()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthenticationRepository _authenticationRepository;

  LoginBloc(this._authenticationRepository) : super(const LoginState()) {
    on<LoginEmailAddressChanged>(_onEmailAddressChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LoginPasswordChanged>(_onPasswordChanged);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.submitting));

    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.success));
    } catch (error) {
      emit(state.copyWith(
        formSubmissionStatus: FormSubmissionStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onEmailAddressChanged(
          LoginEmailAddressChanged event, Emitter<LoginState> emit) async =>
      emit(state.copyWith(
          email: EmailAddress.create(event.value),
          formSubmissionStatus: FormSubmissionStatus.initial));

  Future<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) async =>
      emit(state.copyWith(
          password: Password.create(event.value),
          formSubmissionStatus: FormSubmissionStatus.initial));
}
