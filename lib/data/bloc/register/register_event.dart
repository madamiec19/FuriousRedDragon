part of 'register_bloc.dart';

abstract class RegistrationEvent {}

class RegistrationEmailAddressChanged extends RegistrationEvent {
  final String value;

  RegistrationEmailAddressChanged({required this.value});
}

class RegistrationPasswordChanged extends RegistrationEvent {
  final String value;

  RegistrationPasswordChanged({required this.value});
}

class RegistrationConfirmPasswordChanged extends RegistrationEvent {
  final String value;

  RegistrationConfirmPasswordChanged({required this.value});
}

class RegistrationNameChanged extends RegistrationEvent {
  final String value;

  RegistrationNameChanged({required this.value});
}

class RegistrationRegisterButtonPressed extends RegistrationEvent {}

class RegistrationForgottenPasswordPressed extends RegistrationEvent {}

class RegistrationConfirmPasswordEditingComplete extends RegistrationEvent {}
