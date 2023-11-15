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
      body: Container(
        margin: kSplashInputMargin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: kSplashInputMargin,
              child: Image.asset(kDragonLogoPath, width: kScreenWidth * 0.5),
            ),
            Container(
              color: Colors.white,
              child: Text(
                'WŚCIEKŁY CZERWONY SMOK',
                textAlign: TextAlign.center,
                style: kGlobalTextStyle.copyWith(
                  color: kFuriousRedColor,
                  fontSize: 26,
                  fontFamily: 'Ruslan Display',
                  height: 1.75,
                ),
              ),
            ),
            kBigGap,
            SizedBox(
              width: double.infinity,
              child: BigRedButton(
                  onTap: () {
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                  buttonTitle: 'Zaloguj się'),
            ),
            kBigGap,
            SizedBox(
              width: double.infinity,
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
      ),
    );
  }
}
