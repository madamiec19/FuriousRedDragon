import 'package:flutter/material.dart';

import '../../styles.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: pageBackgroundColor,
        child: ListView(
          children: const [Text('Konto')],
        ));
  }
}
