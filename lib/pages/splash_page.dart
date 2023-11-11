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
            //
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                'images/dragon.png',
                height: 200,
                width: 200,
              ),
              // SvgPicture.asset(
              //   'images/sample.svg',
              //   semanticsLabel: 'My SVG Image',
              //   height: 200.0,
              //   width: 200.0,
              // ),
            ),
          ),
          Container(
            color: Colors.white,
            margin: kSplashInputMargin.copyWith(bottom: 10.0),
            child: const Text(
              'WŚCIEKŁY CZERWONY SMOK',
              style: kTitleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          kSmallGap,
          Container(
            width: double.infinity,
            margin: kSplashInputMargin,
            child: BigRedButton(
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                buttonTitle: "Zaloguj się"),
          ),
          kSmallGap,
          Container(
            width: double.infinity,
            margin: kSplashInputMargin,
            child: BigWhiteButton(
                borderColor: kFuriousRedColor,
                onTap: () {
                  Navigator.pushNamed(context, RegisterPage.routeName);
                },
                buttonTitle: "Zarejestruj się"),
          ),
          kSmallGap,
          BigWhiteButton(
              onTap: () {
                Navigator.pushNamed(context, HomePage.routeName);
              },
              buttonTitle: "Home"),
          kSmallGap,
          // przycisk poniżej do usunięcia na produkcji, użytkownik nie może wejść do aplikacji bez zalogowania się
          SmallButton(
              onTap: () {
                const snackBar = SnackBar(
                  content: Text("klik!"),
                  duration: Duration(milliseconds: 500),
                  backgroundColor: kFuriousRedColor,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              buttonTitle: "SmallButton"),
          kSmallGap,
          SmallButton(
            onTap: () {},
            buttonTitle: "RedSmallButton",
            backgroundColor: kFuriousRedColor,
          )
        ],
      ),
    );
  }
}
