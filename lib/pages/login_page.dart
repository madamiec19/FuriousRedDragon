import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/loginPage';

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            margin: kSplashInputMargin,
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                kDragonLogoPath,
                width: kScreenWidth * 0.35,
              ),
            ),
          ),
          Container(
            margin: kSplashInputMargin,
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ),
          Container(
            margin: kSplashInputMargin,
            child: TextFormField(
              controller:
                  passwordController, // Przypisz kontroler do pola tekstowego.
              decoration: const InputDecoration(labelText: 'Hasło'),
              obscureText: true,
            ),
          ),
          kBigGap,
          BigRedButton(
            onTap: () async {
              try {
                final AuthResponse res = await supabase.auth.signInWithPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
              } on AuthException catch (authError) {
                print('Błąd logowania: $authError');
                _showErrorDialog(context, authError.message);
              }
            },
            buttonTitle: 'Zaloguj się',
          ),
        ],
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
