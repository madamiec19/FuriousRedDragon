import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/register/register_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/input.dart';

class RegisterTokenConfirmPage extends StatelessWidget {
  const RegisterTokenConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Potwierdzenie rejestracji'),
        ),
        body: Container(
          margin: kSplashInputMargin,
          child: Column(children: [
            kBigGap,
            Text(
              'Wprowadź token potwierdzający rejestrację, który został wysłany na Twój adres e-mail.',
              style: kGlobalTextStyle.copyWith(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            kBigGap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: kGlobalTextStyle,
                onChanged: (value) => context
                    .read<RegistrationBloc>()
                    .add(RegistrationTokenChanged(value: value)),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: kPageBackgroundColor,
                ),
                cursorColor: kFuriousRedColor,
              ),
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
        ),
      );
    });
  }
}
