import 'package:flutter/material.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/splash_back_button.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:furious_red_dragon/presentation/components/input.dart';

class ResetPasswordPage extends StatelessWidget {
  final String? email;
  const ResetPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    TextEditingController passwordController1 = TextEditingController();
    TextEditingController passwordController2 = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 30, top: 30),
          child: SplashBackButton(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
