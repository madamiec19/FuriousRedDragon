import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/components/splash_back_button_row.dart';
import 'package:furious_red_dragon/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:furious_red_dragon/components/input.dart';

class ResetPasswordPage extends StatelessWidget {
  final String? email;
  const ResetPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    TextEditingController passwordController1 = TextEditingController();
    TextEditingController passwordController2 = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                    child: Image.asset(
                      kDragonLogoPath,
                      width: kScreenWidth * 0.35,
                    ),
                  ),
                ),
                CustomTextField(
                  labelText: 'Hasło',
                  controller: passwordController1,
                  obscureText: true,
                ),
                CustomTextField(
                  labelText: 'Powtórz hasło',
                  controller: passwordController2,
                  obscureText: true,
                ),
                kBigGap,
                BigRedButton(
                  onTap: () async {
                    if (passwordController1.text == passwordController2.text) {
                      try {
                        // Aktualizuj hasło bez starego hasła
                        final response = await supabase.auth.updateUser(
                          UserAttributes(password: passwordController1.text),
                        );
                        final updatedUser = response.user;
                        print('Zaktualizowano hasło pomyślnie: $updatedUser');
                      } catch (error) {
                        print('Błąd aktualizacji hasła: $error');
                      }
                    } else {
                      print('Hasła nie pasują do siebie.');
                    }
                  },
                  buttonTitle: 'Zatwierdź',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
