import 'package:flutter/material.dart';
import 'package:furious_red_dragon/constants.dart';

class SplashBackButton extends StatelessWidget {
  const SplashBackButton({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: const ButtonStyle(
            iconColor: MaterialStatePropertyAll(Colors.white),
            backgroundColor: MaterialStatePropertyAll(kFuriousRedColor)),
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.west));
  }
}

class SplashBackButtonRow extends StatelessWidget {
  const SplashBackButtonRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(10),
          child: const SplashBackButton(),
        ),
      ],
    );
  }
}
