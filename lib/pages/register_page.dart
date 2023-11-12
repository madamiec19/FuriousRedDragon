import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/components/splash_back_button_row.dart';
import 'package:furious_red_dragon/constants.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const routeName = '/registerPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SplashBackButtonRow(),
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
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                ),
                kBigGap,
                BigRedButton(onTap: () {}, buttonTitle: 'Zarejestruj się'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
