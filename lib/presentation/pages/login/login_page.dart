import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/splash_back_button.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/presentation/pages/login/login_bloc.dart';
import 'package:furious_red_dragon/presentation/pages/home_page.dart';

/// This class creates a Login Page, where a user can login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
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
            onChanged: (password) => context
                .read<LoginBloc>()
                .add(LoginEmailAddressChanged(password)),
            decoration: InputDecoration(
              labelText: 'email',
              labelStyle: kGlobalTextStyle.copyWith(
                color: const Color.fromRGBO(177, 170, 170, 1),
                fontSize: 18,
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              errorText: state.email.hasError ? state.email.errorMessage : null,
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

class _PasswordInputField extends StatelessWidget {
  const _PasswordInputField({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
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
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
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
