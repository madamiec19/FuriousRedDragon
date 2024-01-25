import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/input.dart';
import 'package:furious_red_dragon/presentation/pages/home_page.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// iasdasdgnore: must_be_immutable
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});
  static const routeName = '/changePasswordPage';

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  final supabase = Supabase.instance.client;
  bool ifReset = false;
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController repeatNewPasswordController = TextEditingController();

  // Function to show a SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Store the context

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
        title: const Text('Ustaw nowe hasło'),
        actions: const <Widget>[],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: kSplashInputMargin,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
              CustomTextField(
                labelText: 'Nowe hasło',
                controller: newPasswordController,
                obscureText: true,
                onChange: () {}, // Hide entered characters with asterisks
              ),
              CustomTextField(
                labelText: 'Powtórz nowe hasło',
                controller: repeatNewPasswordController,
                obscureText: true,
                onChange: () {},
              ),
              kBigGap,
              BigRedButton(
                onTap: () async {
                  if (ifReset) return;
                  ifReset = true;
                  // Empty validation
                  if (newPasswordController.text.isEmpty ||
                      repeatNewPasswordController.text.isEmpty) {
                    _showSnackBar(context, 'Wypełnij wszystkie pola');
                    ifReset = true;
                    return;
                  }

                  //Password validation
                  if (newPasswordController.text !=
                      repeatNewPasswordController.text) {
                    newPasswordController.text = '';
                    repeatNewPasswordController.text = '';
                    _showSnackBar(context, 'Hasła nie są identyczne');
                    ifReset = false;
                    return;
                  }

                  // New password validation
                  try {
                    //final correctOldPass = await supabase.auth.admin.password;
                    final UserResponse res = await supabase.auth.updateUser(
                      UserAttributes(
                        password: newPasswordController.text,
                      ),
                    );
                    final User? updatedUser = res.user;
                  } on AuthException catch (authError) {
                    if (authError.message ==
                        'New password should be different from the old password.') {
                      _showSnackBar(context,
                          'Nowe hasło musi być inne od starego hasła.');
                      ifReset = false;
                      return;
                    } else if (authError.message ==
                        'Password should be at least 6 characters.') {
                      _showSnackBar(
                          context, 'Hasło musi zawierać co najmniej 6 znaków');
                      ifReset = false;
                      return;
                    }
                    print('Błąd zmiany hasła: $authError');
                    ifReset = false;
                    return;
                  }
                  _showSnackBar(context, 'Hasło zostało zmienione!');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                buttonTitle: 'Zmień hasło',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
