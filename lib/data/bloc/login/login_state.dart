part of 'login_bloc.dart';

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
