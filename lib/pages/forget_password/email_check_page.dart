import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/components/splash_back_button_row.dart';
import 'package:furious_red_dragon/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:furious_red_dragon/components/input.dart';
import 'reset_password_page.dart';

class EmailCheckPage extends StatelessWidget {
  const EmailCheckPage({super.key});

  static const routeName = '/EmailCheckPage';

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final TextEditingController emailController = TextEditingController();

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
                  labelText: 'Email',
                  controller: emailController,
                ),
                kBigGap,
                BigRedButton(
                  onTap: () async {
                    var email = emailController.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ResetPasswordPage(email: email)));
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
