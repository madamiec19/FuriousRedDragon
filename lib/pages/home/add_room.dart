import 'package:flutter/material.dart';

import '../../constants.dart';

class AddRoomPage extends StatelessWidget {
  const AddRoomPage({super.key});

  static const routeName = '/addRoom';

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(

    )
  }*/
  @override
  Widget build(BuildContext context) {
    return Material(
        color: kPageBackgroundColor,
        child: ListView(
          children: const [Text('Konto')],
        )
    );
  }
}