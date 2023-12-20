import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/presentation/pages/home_page.dart';
import 'package:furious_red_dragon/presentation/pages/welcome_page.dart';
import 'package:furious_red_dragon/domain/services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        color: kFuriousRedColor,
      )),
    );
  }
}
