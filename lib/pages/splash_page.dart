import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/styles.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'register_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: kSplashInputMargin.copyWith(bottom: 10.0),
              child: Image.asset('images/dragon.png'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 60.0),
              child: BigRedButton(
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        )
                      },
                  buttonTitle: "Zaloguj się"),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 60.0),
              child: BigWhiteButton(
                  borderColor: kFuriousRedColor,
                  onTap: () {
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
                  buttonTitle: "Zarejestruj się"),
            ),
            const SizedBox(height: 15),
            BigWhiteButton(
                onTap: () {
                  Navigator.pushNamed(context, HomePage.routeName);
                },
                buttonTitle: "Home"),
            const SizedBox(height: 15),
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
                buttonTitle: "SmallButton")
          ],
        ),
      ),
    );
  }
}
