import 'package:flutter/material.dart';
import 'package:furious_red_dragon/main.dart';
import 'package:furious_red_dragon/pages/home/account_page.dart';
import 'package:furious_red_dragon/pages/home/help_page.dart';
import 'package:furious_red_dragon/pages/home/history_page.dart';
import 'package:furious_red_dragon/pages/home/scanner_page.dart';
import 'package:furious_red_dragon/pages/home/settings_page.dart';
import 'package:furious_red_dragon/sevices/auth_service.dart';
import '../components/nav_tabs.dart';
import '../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: kFuriousRedColor,
          title: Text('Witaj, ${AuthService(client).getEmail()}'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () {
                  // Przenieś się do innej strony po kliknięciu
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
                child: const Icon(Icons.settings),
              ),
            ),
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
    );
  }
}
