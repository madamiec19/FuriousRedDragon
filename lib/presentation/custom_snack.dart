import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';

class CustomSnack extends StatelessWidget {
  const CustomSnack({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      backgroundColor: kFuriousRedColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 150,
        left: 10,
        right: 10,
      ),
    );
  }
}
