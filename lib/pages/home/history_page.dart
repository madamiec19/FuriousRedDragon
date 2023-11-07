import 'package:flutter/material.dart';

import '../../styles.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: pageBackgroundColor,
        child: ListView(
          children: const [Text('Historia')],
        ));
  }
}
