import 'package:flutter/material.dart';
import 'package:furious_red_dragon/pages/home/account_page.dart';
import 'package:furious_red_dragon/pages/home/help_page.dart';
import 'package:furious_red_dragon/pages/home/history_page.dart';
import 'package:furious_red_dragon/pages/home/scanner_page.dart';
import 'package:furious_red_dragon/pages/splash_page.dart';

import '../components/nav_tabs.dart';
import '../styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            )),
            backgroundColor: furiousRedColor,
            title: const Text("Witaj, imię"),
            // przycisk poniżej do usunięcia na produkcji, użytkownik nie może wrócić w ten sposób do SplashPage (po wylogowaniu będzie można)
            leading: BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashPage()),
                );
              },
            ),
            actions: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.settings),
              )
            ],
          ),
          bottomNavigationBar: const NavTabs(),
          body: const TabBarView(
            children: [
              AccountPage(),
              HistoryPage(),
              ScannerPage(),
              HelpPage(),
            ],
          ),
        ),
      ),
    );
  }
}
