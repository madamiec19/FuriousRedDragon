import 'package:equatable/equatable.dart';

class EmailAddress extends Equatable {
  final String value;
  final String errorMessage;
  final bool hasError;

  const EmailAddress({
    required this.value,
    required this.errorMessage,
    required this.hasError,
  });

  factory EmailAddress.create(String value) {
    if (value.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return EmailAddress(
          value: value,
          errorMessage: 'Wpisz poprawny adres email',
          hasError: true);
    }
    return EmailAddress(value: value, errorMessage: '', hasError: false);
  }

  @override
  List<Object?> get props => [value, errorMessage, hasError];

  static const empty = EmailAddress(
    value: '',
    errorMessage: '',
    hasError: false,
  );
}
