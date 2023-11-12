import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/loginPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kFuriousRedColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            margin: kSplashInputMargin,
            //
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                'images/dragon.png',
                height: 100,
                width: 100,
              ),
              // SvgPicture.asset(
              //   'images/sample.svg',
              //   semanticsLabel: 'My SVG Image',
              //   height: 100.0,
              //   width: 100.0,
              // ),
            ),
          ),
          Container(
            margin: kSplashInputMargin,
            child: TextFormField(),
          ),
          Container(
            margin: kSplashInputMargin,
            child: TextFormField(),
          ),
          kBigGap,
          BigRedButton(
            onTap: () {},
            buttonTitle: "Zaloguj się",
          ),
        ],
      ),
    );
  }
}
