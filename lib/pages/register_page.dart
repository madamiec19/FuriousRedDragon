import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/constants.dart';

import '../main.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  static const routeName = '/registerPage';

  // Controllers for email, password, and repeat password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  // Function to show a SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kFuriousRedColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SplashBackButtonRow(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  margin: kSplashInputMargin,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(kDragonLogoPath,
                        width: kScreenWidth * 0.35),
                  ),
                ),
                Container(
                  margin: kSplashInputMargin,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _showSnackBar(context, 'Wpisz adres e-mail');
                        return 'Wpisz adres e-mail';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        _showSnackBar(context, 'Wpisz poprawny adres e-mail');
                        return 'Wpisz poprawny adres e-mail';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: kSplashInputMargin,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Hasło'),
                    obscureText: true, // Hide entered characters with asterisks
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _showSnackBar(context, 'Wpisz hasło');
                        return 'Wpisz hasło';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: kSplashInputMargin,
                  child: TextFormField(
                    controller: repeatPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'Powtórz hasło'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _showSnackBar(context, 'Powtórz hasło');
                        return 'Powtórz hasło';
                      } else if (value != passwordController.text) {
                        _showSnackBar(context, 'Hasła nie są identyczne');
                        return 'Hasła nie są identyczne';
                      }
                      return null;
                    },
                  ),
                ),
                kBigGap,
                BigRedButton(
                  onTap: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        repeatPasswordController.text.isEmpty) {
                      _showSnackBar(context, 'Wypełnij wszystkie pola');
                    } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(emailController.text)) {
                      _showSnackBar(context, 'Wpisz poprawny adres e-mail');
                      return 'Wpisz poprawny adres e-mail';
                    } else if (passwordController.text ==
                        repeatPasswordController.text) {
                      await supabase.auth.signUp(
                          password: passwordController.text,
                          email: emailController.text);
                      await supabase.from('roles').insert([
                        {
                          'status': 'admin',
                          'password': passwordController.text,
                          'email': emailController.text,
                        }
                      ]);
                    } else {
                      _showSnackBar(context, 'Hasła nie są identyczne');
                    }
                  },
                  buttonTitle: 'Zarejestruj się',
                ),
              ],
            ),
          ),
          Container(
            margin: kSplashInputMargin,
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ),
          kBigGap,
          BigRedButton(onTap: () {}, buttonTitle: 'Zarejestruj się'),
        ],
      ),
    );
  }
}
