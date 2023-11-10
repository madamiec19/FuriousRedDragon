import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Row(
            children: [
              BackButton(),
            ],
          ),
          const Gap(18),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const Gap(18),
          ElevatedButton(
            onPressed: () => {},
            child: const Text("Zarejestruj się"),
          ),
        ],
      ),
    );
  }
}
