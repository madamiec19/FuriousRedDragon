part of 'register_bloc.dart';

enum FormSubmissionStatus {
  initial,
  submitting,
  success,
  failure,
  confirmPasswordNotMachWithPassword,
}

class RegistrationState extends Equatable {
  final EmailAddress email;
  final Password password;
  final Password confirmPassword;
  final FormSubmissionStatus formSubmissionStatus;
  final String? errorMessage;

  const RegistrationState({
    this.email = EmailAddress.empty,
    this.password = Password.empty,
    this.confirmPassword = Password.empty,
    this.formSubmissionStatus = FormSubmissionStatus.initial,
    this.errorMessage = '',
  });

  RegistrationState copyWith({
    EmailAddress? email,
    Password? password,
    Password? confirmPassword,
    FormSubmissionStatus? formSubmissionStatus,
    String? errorMessage,
  }) =>
      RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        formSubmissionStatus,
        errorMessage,
      ];

  bool isSubmitting() =>
      formSubmissionStatus == FormSubmissionStatus.submitting;

  bool isSubmissionSuccessOrFailure() =>
      formSubmissionStatus == FormSubmissionStatus.success ||
      formSubmissionStatus == FormSubmissionStatus.failure ||
      formSubmissionStatus ==
          FormSubmissionStatus.confirmPasswordNotMachWithPassword;

  bool get isValid =>
      !email.hasError && !password.hasError && !confirmPassword.hasError;
}
