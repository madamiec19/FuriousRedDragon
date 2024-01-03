import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/login/login_bloc.dart';
import 'package:furious_red_dragon/data/bloc/register/register_bloc.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function onChange;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => current.password != previous.password,
      builder: (context, state) => Container(
        margin: const EdgeInsets.fromLTRB(43, 10, 43, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(255, 232, 232, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          onChanged: widget.onChange(),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'hasło',
            labelStyle: kGlobalTextStyle.copyWith(
              color: const Color.fromRGBO(177, 170, 170, 1),
              fontSize: 18,
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            errorText:
                state.password.hasError ? state.password.errorMessage : null,
          ),
          style: kGlobalTextStyle.copyWith(
            color: const Color.fromARGB(255, 2, 2, 2),
            fontSize: 18,
          ),
          cursorColor: kFuriousRedColor,
        ),
      ),
    );
  }
}

class CredentialsTextField extends StatefulWidget {
  const CredentialsTextField(
      {super.key,
      required this.errorText,
      required this.obscureText,
      required this.onChanged,
      required this.labelText});

  final String? errorText;
  final bool obscureText;
  final Function onChanged;
  final String labelText;

  @override
  State<CredentialsTextField> createState() => _CredentialsTextFieldState();
}

class _CredentialsTextFieldState extends State<CredentialsTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(43, 10, 43, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(255, 232, 232, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 4, top: 4),
          child: TextFormField(
            onChanged: widget.onChanged(),
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: kGlobalTextStyle.copyWith(
                color: const Color.fromRGBO(177, 170, 170, 1),
                fontSize: 18,
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              errorText: widget.errorText ?? '',
            ),
          ),
        ));
  }
}
