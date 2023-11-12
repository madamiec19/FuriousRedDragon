import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/constants.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'register_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const routeName = '/splashPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: kSplashInputMargin,
            child: Hero(
              tag: 'logo',
              child: Image.asset(kDragonLogoPath, width: kScreenWidth * 0.5),
            ),
          ),
          Container(
            color: Colors.white,
            margin: kSplashInputMargin.copyWith(bottom: 10),
            child: const Text(
              'WŚCIEKŁY CZERWONY SMOK',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kFuriousRedColor,
                fontSize: 20,
                fontFamily: 'Ruslan Display',
                fontWeight: FontWeight.w400,
                height: 1.75,
                letterSpacing: 0.41,
              ),
            ),
          ),
          kBigGap,
          Container(
            width: double.infinity,
            margin: kSplashInputMargin,
            child: BigRedButton(
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                buttonTitle: 'Zaloguj się'),
          ),
          kBigGap,
          Container(
            width: double.infinity,
            margin: kSplashInputMargin,
            child: BigWhiteButton(
                borderColor: kFuriousRedColor,
                onTap: () {
                  Navigator.pushNamed(context, RegisterPage.routeName);
                },
                buttonTitle: 'Zarejestruj się'),
          ),
          kMediumGap,
          // przycisk poniżej do usunięcia na produkcji, użytkownik nie może wejść do aplikacji bez zalogowania się
          SmallButton(
              onTap: () {
                Navigator.pushNamed(context, HomePage.routeName);
              },
              buttonTitle: 'Home'),
        ],
      ),
    );
  }
}
