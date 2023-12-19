import 'package:equatable/equatable.dart';

class Password extends Equatable {
  final String value;
  final String errorMessage;
  final bool hasError;

  const Password({
    required this.value,
    required this.errorMessage,
    required this.hasError,
  });

  factory Password.create(String value) {
    if (value.isEmpty || value.length < 6) {
      return Password(
          value: value,
          errorMessage: 'Hasło powinno mieć co najmniej 8 znaków',
          hasError: true);
    }
    return Password(value: value, errorMessage: '', hasError: false);
  }

  @override
  List<Object?> get props => [value, errorMessage, hasError];

  static const empty = Password(
    value: '',
    errorMessage: '',
    hasError: false,
  );
}
