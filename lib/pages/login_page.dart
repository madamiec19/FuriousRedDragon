import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/loginPage';

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
          Container(
            margin: kSplashInputMargin,
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ),
          const SizedBox(
            height: 18.0,
          ),
          BigRedButton(
            onTap: () {},
            buttonTitle: "Zaloguj się",
          ),
        ],
      ),
    );
  }
}
