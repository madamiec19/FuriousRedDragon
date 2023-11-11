import 'package:flutter/material.dart';

import '../../constants.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: kPageBackgroundColor,
        child: ListView(
          children: const [Text('Historia')],
        ));
  }
}
