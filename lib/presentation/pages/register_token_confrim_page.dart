import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/register/register_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class RegisterTokenConfirmPage extends StatelessWidget {
  const RegisterTokenConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          const Text(
              'Wprowadź token potwierdzający rejestrację, który został wysłany na Twój adres e-mail.'),
          kMediumGap,
          TextField(
            decoration: const InputDecoration(labelText: 'Token'),
            keyboardType: TextInputType.number,
            onChanged: (value) => context
                .read<RegistrationBloc>()
                .add(RegistrationTokenChanged(value: value)),
          ),
          kBigGap,
          BigRedButton(
              onTap: () => state.isTokenNotEmpty()
                  ? context
                      .read<RegistrationBloc>()
                      .add(RegistrationTokenConfirmButtonPressed())
                  : {},
              buttonTitle: 'Zweryfikuj')
        ]),
      );
    });
  }
}
