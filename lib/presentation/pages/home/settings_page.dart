import 'package:flutter/material.dart';
import 'package:furious_red_dragon/presentation/pages/welcome_page.dart';
import 'package:furious_red_dragon/domain/services/auth_service.dart';
import 'delete_account.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/core/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        )),
        backgroundColor: kFuriousRedColor,
        title: const Text('Ustawienia'),
        actions: const <Widget>[],
      ),
      body: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ustawienia',
                style: kGlobalTextStyle.copyWith(fontSize: 32),
              ),
              kBigGap,
              BigWhiteButton(
                onTap: () {
                  print('Zmiana hasła');
                },
                buttonTitle: ('Zmień hasło'),
              ),
              kMediumGap,
              BigWhiteButton(
                onTap: () {
                  // Przejście do podstrony delete_account.dart po kliknięciu "Usuń konto"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DeleteAccountPage()),
                  );
                },
                buttonTitle: ('Usuń konto'),
              ),
              kMediumGap,
              BigWhiteButton(
                  onTap: () async {
                    await AuthService(client).signOut();
                    getBackToSplash(context);
                  },
                  buttonTitle: 'Wyloguj')
            ],
          ),
        ),
      ),
    );
  }

  void getBackToSplash(context) {
    Navigator.popUntil(context, ModalRoute.withName('/welcomePage'));
    Navigator.pushNamed(context, WelcomePage.routeName);
  }
}
