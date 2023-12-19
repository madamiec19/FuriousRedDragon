import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/entities/email_address.dart';
import 'package:furious_red_dragon/domain/repositories/entities/password.dart';
import 'package:injectable/injectable.dart';

@injectable
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
    } catch (_) {
      emit(state.copyWith(formSubmissionStatus: FormSubmissionStatus.failure));
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

abstract class LoginEvent {}

class LoginEmailAddressChanged extends LoginEvent {
  final String value;

  LoginEmailAddressChanged(this.value);
}

class LoginPasswordChanged extends LoginEvent {
  final String value;

  LoginPasswordChanged(this.value);
}

class LoginButtonPressed extends LoginEvent {}

enum FormSubmissionStatus {
  initial,
  submitting,
  success,
  failure,
}

class LoginState extends Equatable {
  final EmailAddress email;
  final Password password;
  final FormSubmissionStatus formSubmissionStatus;

  const LoginState({
    this.email = EmailAddress.empty,
    this.password = Password.empty,
    this.formSubmissionStatus = FormSubmissionStatus.initial,
  });

  LoginState copyWith({
    EmailAddress? email,
    Password? password,
    FormSubmissionStatus? formSubmissionStatus,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        formSubmissionStatus,
      ];

  bool isSubmitting() =>
      formSubmissionStatus == FormSubmissionStatus.submitting;

  bool isSubMissionSuccessOrFailure() =>
      formSubmissionStatus == FormSubmissionStatus.success ||
      formSubmissionStatus == FormSubmissionStatus.failure;

  bool get isValid => !email.hasError && !password.hasError;
}
