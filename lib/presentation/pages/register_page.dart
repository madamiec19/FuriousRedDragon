import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../data/bloc/register/register_bloc.dart';
import '../components/buttons.dart';
import '../components/splash_back_button.dart';
import 'login/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const routeName = '/registerPage';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 70,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 30, top: 30),
          child: SplashBackButton(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: kSplashInputMargin,
                child: Image.asset(kDragonLogoPath, width: kScreenWidth * 0.35),
              ),
              Container(
                margin: kSplashInputMargin,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Załóż konto dla swojej firmy i zacznij inwentaryzować już dziś!',
                    textAlign: TextAlign.center,
                    style: kGlobalTextStyle.copyWith(fontSize: 24),
                  ),
                ),
              ),
              const _RegistrationForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegistrationForm extends StatelessWidget {
  const _RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocListener<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) =>
            current.isSubmissionSuccessOrFailure(),
        listener: (context, state) {
          if (state.formSubmissionStatus == FormSubmissionStatus.success) {
            Navigator.pushReplacementNamed(context, LoginPage.routeName);
          }

          if (state.formSubmissionStatus == FormSubmissionStatus.failure) {
            _showErrorDialog(context, state.errorMessage!);
          }

          if (state.formSubmissionStatus ==
              FormSubmissionStatus.confirmPasswordNotMachWithPassword) {
            _showErrorDialog(context, 'Hasła nie są takie same');
          }
        },
        child: const Column(
          children: [
            _EmailInputField(),
            _PasswordInputField(),
            _ConfirmPasswordInputField(),
            kSmallGap,
            _RegisterButton(),
          ],
        ),
      );
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
          buildWhen: (previous, current) => current.email != previous.email,
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
                  onChanged: (email) => context
                      .read<RegistrationBloc>()
                      .add(RegistrationEmailAddressChanged(value: email)),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'email',
                    labelStyle: kGlobalTextStyle.copyWith(
                      color: const Color.fromRGBO(177, 170, 170, 1),
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    errorText:
                        state.email.hasError ? state.email.errorMessage : null,
                  ),
                  style: kGlobalTextStyle.copyWith(
                    color: const Color.fromARGB(255, 2, 2, 2),
                    fontSize: 18,
                  ),
                  cursorColor: kFuriousRedColor,
                ),
              ));
}

class _PasswordInputField extends StatelessWidget {
  const _PasswordInputField();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
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
          child: TextFormField(
            onChanged: (password) => context
                .read<RegistrationBloc>()
                .add(RegistrationPasswordChanged(value: password)),
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
          ),
        ),
      );
}

class _ConfirmPasswordInputField extends StatelessWidget {
  const _ConfirmPasswordInputField();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) =>
            current.confirmPassword != previous.confirmPassword,
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
          child: TextFormField(
            onChanged: (confirmPassword) => context
                .read<RegistrationBloc>()
                .add(
                    RegistrationConfirmPasswordChanged(value: confirmPassword)),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'potwierdź hasło',
              labelStyle: kGlobalTextStyle.copyWith(
                color: const Color.fromRGBO(177, 170, 170, 1),
                fontSize: 18,
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              errorText: state.confirmPassword.hasError
                  ? state.confirmPassword.errorMessage
                  : null,
            ),
          ),
        ),
      );
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) => BigRedButton(
          onTap: () => state.isSubmitting() || !state.isValid
              ? null
              : context
                  .read<RegistrationBloc>()
                  .add(RegistrationRegisterButtonPressed()),
          buttonTitle: state.isSubmitting() ? 'Rejestracja...' : 'Zarejestruj',
        ),
      );
}

void _showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Błąd logowania'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
