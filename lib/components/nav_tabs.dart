import 'package:flutter/material.dart';

import '../constants.dart';

class NavTabs extends StatelessWidget {
  const NavTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kFuriousRedColor,
      child: TabBar(
        indicator: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Tab(
              text: "Konto",
              icon: Icon(Icons.account_circle_outlined),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Tab(
              text: "Historia",
              icon: Icon(Icons.menu_book_outlined),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Tab(
              text: "Skanuj",
              icon: Icon(Icons.camera_alt_outlined),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Tab(
              text: "Pomoc",
              icon: Icon(Icons.help_outline_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
