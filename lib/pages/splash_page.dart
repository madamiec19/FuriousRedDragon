import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'register_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      )
                    },
                child: const Text("Zaloguj się")),
            const Gap(15),
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      )
                    },
                child: const Text("Zarejestruj się")),
            const Gap(15),
            // przycisk poniżej do usunięcia na produkcji, użytkownik nie może wejść do aplikacji bez zalogowania się
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      )
                    },
                child: const Text("Home"))
          ],
        ),
      ),
    );
  }
}
