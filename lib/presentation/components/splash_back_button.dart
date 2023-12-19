import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';

class SplashBackButton extends StatelessWidget {
  const SplashBackButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: TextButton(
        style: const ButtonStyle(
          iconColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStatePropertyAll(kFuriousRedColor),
        ),
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.west),
      ),
    );
  }
}
