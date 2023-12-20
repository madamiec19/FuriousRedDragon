import 'package:flutter/material.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/splash_back_button.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:furious_red_dragon/presentation/components/input.dart';
import 'reset_password_page.dart';

class EmailCheckPage extends StatelessWidget {
  const EmailCheckPage({super.key});

  static const routeName = '/EmailCheckPage';

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {},
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
