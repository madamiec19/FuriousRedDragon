import 'package:flutter/material.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/splash_back_button.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/domain/services/auth_service.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:furious_red_dragon/presentation/components/input.dart';
import 'package:furious_red_dragon/presentation/pages/home_page.dart';
import 'package:furious_red_dragon/presentation/pages/forget_password/email_check_page.dart';

/// This class creates a Login Page, where a user can login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      progressIndicator: const CircularProgressIndicator(
        color: kFuriousRedColor,
      ),
      child: Scaffold(
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
                CustomTextField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                CustomTextField(
                  labelText: 'Hasło',
                  controller: passwordController,
                  obscureText: true,
                ),
                ForgotPasswordText(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EmailCheckPage()));
                  },
                ),
                kBigGap,
                BigRedButton(
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      AuthService auth = AuthService(client);
                      await auth.signInUser(emailController.text.trim(),
                          passwordController.text.trim());
                      if (auth.isLoggedIn()) {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/welcomePage'));
                        Navigator.pushReplacementNamed(
                            context, HomePage.routeName);
                      } else {
                        _showErrorDialog(context, '');
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      _showErrorDialog(context, e.toString());
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                  buttonTitle: 'Zaloguj się',
                ),
              ],
            ),
          ),
        ),
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
}
