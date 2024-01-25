import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/auth_bloc.dart';
import 'package:furious_red_dragon/presentation/pages/change_password.dart';
import '../../welcome_page.dart';
import 'delete_account.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/core/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthStatus>(
      listener: (BuildContext context, AuthStatus state) {
        if (state is AuthInitial) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, WelcomePage.routeName);
        }
      },
      child: Scaffold(
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const ChangePasswordPage()),
                    // );
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
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLogoutButtonPressed());
                  },
                  buttonTitle: 'Wyloguj',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
