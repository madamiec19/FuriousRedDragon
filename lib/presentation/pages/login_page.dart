import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/splash_back_button.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/login/login_bloc.dart';
import 'package:furious_red_dragon/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/login-page';

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
                child: Image.asset(
                  kDragonLogoPath,
                  width: kScreenWidth * 0.35,
                ),
              ),
              kBigGap,
              Container(
                margin: kSplashInputMargin,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Zaloguj się, aby zacząć inwentaryzację!',
                    textAlign: TextAlign.center,
                    style: kGlobalTextStyle.copyWith(fontSize: 24),
                  ),
                ),
              ),
              const _LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) => BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            current.isSubMissionSuccessOrFailure(),
        listener: (context, state) {
          if (state.formSubmissionStatus == FormSubmissionStatus.success) {
            Navigator.popUntil(context, ModalRoute.withName('/welcomePage'));
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          }
          if (state.formSubmissionStatus == FormSubmissionStatus.failure) {
            _showErrorDialog(context, state.errorMessage!);
          }
        },
        child: const Column(
          children: [
            _EmailInputField(),
            kSmallGap,
            _PasswordInputField(),
            kBigGap,
            _LoginButton()
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
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) => current.email != previous.email,
          builder: (context, state) => TextField(
            onChanged: (email) =>
                context.read<LoginBloc>().add(LoginEmailAddressChanged(email)),
            decoration: kCredentialsTextFieldInputDecoration.copyWith(
              labelText: 'email',
              errorText: state.email.hasError
                  ? state.email.errorMessage.toString()
                  : null,
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
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) =>
              current.password != previous.password,
          builder: (context, state) => TextField(
            obscureText: true,
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            decoration: kCredentialsTextFieldInputDecoration.copyWith(
              labelText: 'hasło',
              errorText:
                  state.password.hasError ? state.password.errorMessage : null,
            ),
            style: kCredentialsTextStyle,
            cursorColor: kFuriousRedColor,
          ),
        ),
      );
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => BigRedButton(
            onTap: () => state.isSubmitting() || !state.isValid
                ? null
                : context.read<LoginBloc>().add(LoginButtonPressed()),
            buttonTitle: state.isSubmitting() ? 'Logowanie...' : 'Login',
          ));
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
