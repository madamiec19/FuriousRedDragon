import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/presentation/pages/login_page.dart';

import '../../core/constants.dart';
import '../../data/bloc/register/register_bloc.dart';
import '../components/buttons.dart';
import '../components/splash_back_button.dart';

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
        backgroundColor: Colors.transparent,
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
  Widget build(BuildContext context) => Container(
        margin: kSplashInputMargin.copyWith(bottom: 20),
        decoration: kCredentialsTextFieldContainerDecoration,
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          buildWhen: (previous, current) => current.email != previous.email,
          builder: (context, state) => TextField(
            onChanged: (email) => context
                .read<RegistrationBloc>()
                .add(RegistrationEmailAddressChanged(value: email)),
            keyboardType: TextInputType.emailAddress,
            decoration: kCredentialsTextFieldInputDecoration.copyWith(
              errorText: state.email.hasError ? state.email.errorMessage : null,
              labelText: 'email',
            ),
            style: kCredentialsTextStyle,
            cursorColor: kFuriousRedColor,
          ),
        ),
      );
}

class _PasswordInputField extends StatelessWidget {
  const _PasswordInputField();

  @override
  Widget build(BuildContext context) => Container(
        margin: kSplashInputMargin.copyWith(bottom: 20),
        decoration: kCredentialsTextFieldContainerDecoration,
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          buildWhen: (previous, current) =>
              current.password != previous.password,
          builder: (context, state) => TextField(
            onChanged: (password) => context
                .read<RegistrationBloc>()
                .add(RegistrationPasswordChanged(value: password)),
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: kCredentialsTextFieldInputDecoration.copyWith(
              errorText:
                  state.password.hasError ? state.password.errorMessage : null,
              labelText: 'hasło',
            ),
            style: kCredentialsTextStyle,
            cursorColor: kFuriousRedColor,
          ),
        ),
      );
}

class _ConfirmPasswordInputField extends StatelessWidget {
  const _ConfirmPasswordInputField();

  @override
  Widget build(BuildContext context) => Container(
        margin: kSplashInputMargin.copyWith(bottom: 20),
        decoration: kCredentialsTextFieldContainerDecoration,
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          buildWhen: (previous, current) =>
              current.confirmPassword != previous.confirmPassword,
          builder: (context, state) => TextField(
            onChanged: (password) => context
                .read<RegistrationBloc>()
                .add(RegistrationConfirmPasswordChanged(value: password)),
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: kCredentialsTextFieldInputDecoration.copyWith(
              labelText: 'potwierdź hasło',
              errorText: state.confirmPassword.hasError
                  ? state.confirmPassword.errorMessage
                  : null,
            ),
            style: kCredentialsTextStyle,
            cursorColor: kFuriousRedColor,
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
