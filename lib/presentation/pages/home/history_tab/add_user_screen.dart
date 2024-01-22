import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/auth_bloc.dart';
import 'package:furious_red_dragon/data/bloc/history_database/history_database_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/input.dart';
import 'package:furious_red_dragon/presentation/components/white_card.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<HistoryDatabaseBloc>()
            .add(HistoryAdminUsersButtonClicked());
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dodaj użytkownika'),
        ),
        body: WhiteCard(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  labelText: 'Nazwa',
                  controller: nameController,
                  onChange: () {},
                ),
                CustomTextField(
                    labelText: 'Email',
                    controller: emailController,
                    onChange: () {}),
                CustomTextField(
                  labelText: 'Hasło',
                  controller: passwordController,
                  onChange: () {},
                  obscureText: true,
                ),
                CustomTextField(
                  labelText: 'Powtórz hasło',
                  controller: repeatPasswordController,
                  onChange: () {},
                  obscureText: true,
                ),
                kBigGap,
                BigRedButton(
                  onTap: () {
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        repeatPasswordController.text.isEmpty) {
                      _showSnackBar('Wypełnij wszystkie pola', context);
                      return;
                    }

                    // Password validation
                    if (passwordController.text !=
                        repeatPasswordController.text) {
                      _showSnackBar('Hasła nie są identyczne', context);
                      return;
                    }

                    // E-mail validation
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(emailController.text)) {
                      _showSnackBar('Wpisz poprawny adres e-mail', context);
                      return;
                    }
                    context.read<AuthBloc>().add(AuthAdminUserAdding(
                        nameController.text,
                        emailController.text,
                        passwordController.text));
                    context
                        .read<HistoryDatabaseBloc>()
                        .add(HistoryAdminUsersButtonClicked());
                    Navigator.pop(context);
                  },
                  buttonTitle: 'Dodaj',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(String message, BuildContext context) {
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
