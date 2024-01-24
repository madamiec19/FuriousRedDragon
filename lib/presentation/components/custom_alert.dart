import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({super.key, required this.title, required this.onPressed});

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: kFuriousRedColor,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => onPressed(),
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
