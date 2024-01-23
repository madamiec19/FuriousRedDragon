import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/entities/email_address.dart';
import 'package:furious_red_dragon/domain/repositories/entities/password.dart';
import 'package:injectable/injectable.dart';

part 'register_event.dart';
part 'register_state.dart';
// TODO dodać obsługę walidacji poprzez kod z maila

/// Obsługa rejestracji
@Injectable()
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final IAuthenticationRepository _authenticationRepository;

  RegistrationBloc(this._authenticationRepository)
      : super(const RegistrationState()) {
    on<RegistrationRegisterButtonPressed>(_onRegistrationButtonPressed);
    on<RegistrationEmailAddressChanged>(_onEmailAddressChanged);
    on<RegistrationPasswordChanged>(_onPasswordChanged);
    on<RegistrationConfirmPasswordChanged>(_onConfirmPasswordChanged);
  }

  Future<void> _onRegistrationButtonPressed(
    RegistrationRegisterButtonPressed event,
    Emitter<RegistrationState> emit,
  ) async {
    if (!state.isValid) {
      return;
    }

    emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.submitting));

    if (!_isConfirmPasswordMatchWithPassword(
        state.password.value, state.confirmPassword.value)) {
      emit(state.copyWith(
          formSubmissionStatus:
              FormSubmissionStatus.confirmPasswordNotMachWithPassword));
      return;
    }

    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
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
    RegistrationEmailAddressChanged event,
    Emitter<RegistrationState> emit,
  ) async =>
      emit(state.copyWith(
        email: EmailAddress.create(event.value),
        formSubmissionStatus: FormSubmissionStatus.initial,
      ));

  Future<void> _onPasswordChanged(
    RegistrationPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) async =>
      emit(state.copyWith(
        password: Password.create(event.value),
        formSubmissionStatus: FormSubmissionStatus.initial,
      ));

  Future<void> _onConfirmPasswordChanged(
    RegistrationConfirmPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) async =>
      emit(state.copyWith(
        confirmPassword: Password.create(event.value),
        formSubmissionStatus: FormSubmissionStatus.initial,
      ));

  bool _isConfirmPasswordMatchWithPassword(
    String password,
    String confirmPassword,
  ) =>
      password == confirmPassword;
}
