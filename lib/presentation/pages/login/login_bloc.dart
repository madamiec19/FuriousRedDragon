import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/entities/email_address.dart';
import 'package:furious_red_dragon/domain/repositories/entities/password.dart';
import 'package:injectable/injectable.dart';

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

//Events
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

//Status
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
  final String? errorMessage;

  const LoginState(
      {this.email = EmailAddress.empty,
      this.password = Password.empty,
      this.formSubmissionStatus = FormSubmissionStatus.initial,
      this.errorMessage});

  LoginState copyWith({
    EmailAddress? email,
    Password? password,
    FormSubmissionStatus? formSubmissionStatus,
    String? errorMessage,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        formSubmissionStatus,
        errorMessage,
      ];

  bool isSubmitting() =>
      formSubmissionStatus == FormSubmissionStatus.submitting;

  bool isSubMissionSuccessOrFailure() =>
      formSubmissionStatus == FormSubmissionStatus.success ||
      formSubmissionStatus == FormSubmissionStatus.failure;

  bool get isValid => !email.hasError && !password.hasError;
}
