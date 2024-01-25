part of 'register_bloc.dart';

enum FormSubmissionStatus {
  initial,
  submitting,
  success,
  failure,
  confirmPasswordNotMachWithPassword,
  waitingForTokenConfirm,
}

class RegistrationState extends Equatable {
  final EmailAddress email;
  final Password password;
  final Password confirmPassword;
  final String name;
  final FormSubmissionStatus formSubmissionStatus;
  final String? errorMessage;
  final String token;

  const RegistrationState({
    this.email = EmailAddress.empty,
    this.password = Password.empty,
    this.confirmPassword = Password.empty,
    this.formSubmissionStatus = FormSubmissionStatus.initial,
    this.errorMessage = '',
    this.name = '',
    this.token = '',
  });

  RegistrationState copyWith({
    EmailAddress? email,
    Password? password,
    Password? confirmPassword,
    FormSubmissionStatus? formSubmissionStatus,
    String? errorMessage,
    String? name,
    String? token,
  }) =>
      RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        name: name ?? this.name,
        token: token ?? this.token,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        formSubmissionStatus,
        errorMessage,
        name,
        token,
      ];

  bool isSubmitting() =>
      formSubmissionStatus == FormSubmissionStatus.submitting;

  bool isSuccess() => formSubmissionStatus == FormSubmissionStatus.success;

  bool isSubmissionSuccessOrFailure() =>
      formSubmissionStatus == FormSubmissionStatus.success ||
      formSubmissionStatus == FormSubmissionStatus.failure ||
      formSubmissionStatus ==
          FormSubmissionStatus.confirmPasswordNotMachWithPassword ||
      formSubmissionStatus == FormSubmissionStatus.waitingForTokenConfirm;

  bool get isValid =>
      !email.hasError &&
      !password.hasError &&
      !confirmPassword.hasError &&
      name.isNotEmpty;

  bool isTokenNotEmpty() => token.isNotEmpty;
}
