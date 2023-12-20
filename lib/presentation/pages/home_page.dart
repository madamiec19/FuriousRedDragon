import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/auth_bloc.dart';
import 'package:furious_red_dragon/presentation/pages/home/account_page.dart';
import 'package:furious_red_dragon/presentation/pages/home/help_page.dart';
import 'package:furious_red_dragon/presentation/pages/home/history_tab/history_page.dart';
import 'package:furious_red_dragon/presentation/pages/home/scanner_page.dart';
import 'package:furious_red_dragon/presentation/pages/home/settings_page.dart';
import 'package:furious_red_dragon/domain/services/auth_service.dart';
import 'package:furious_red_dragon/presentation/pages/welcome_page.dart';
import '../components/nav_tabs.dart';
import 'package:furious_red_dragon/core/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthStatus>(
      listener: (BuildContext context, state) {
        if (state is AuthUserUnauthenticated) {
          Navigator.pushReplacementNamed(context, WelcomePage.routeName);
        }
      },
      child: DefaultTabController(
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
            title: const TextNameAppBar(),
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
      ),
    );
  }
}

class TextNameAppBar extends StatelessWidget {
  const TextNameAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthStatus>(
      builder: (context, state) {
        if (state is AuthUserAuthenticated) {
          String email = state.user.email.toString();
          return Text('Witaj, $email ');
        }
        return const Placeholder();
      },
    );
  }
}
