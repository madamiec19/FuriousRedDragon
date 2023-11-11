import 'package:flutter/material.dart';

import '../../constants.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: kPageBackgroundColor,
        child: ListView(
          children: const [Text('Pomoc')],
        ));
  }
}
