import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'add_room.dart';
import 'package:furious_red_dragon/core/constants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPageBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigWhiteButton(
            onTap: () {
              Navigator.pushNamed(context, AddRoomPage.routeName);
            },
            buttonTitle: 'Dodaj salę',
          ),
          BigWhiteButton(
            onTap: () {
              context.read<ReportBloc>().add(ReportInitialized(
                  idAuthor: 2, createdAt: DateTime.now(), idRoom: 1));
            },
            buttonTitle: 'inicjalizacja raportu',
          ),
          BigWhiteButton(
            onTap: () {
              var state = BlocProvider.of<ReportBloc>(context).state;
              print(state.report.id);
            },
            buttonTitle: 'print id rozpoczatego raportu',
          ),
          BigWhiteButton(
            onTap: () {
              context.read<ReportBloc>().add(ReportItemScanned(code: '123214'));
            },
            buttonTitle: 'udpate raportu',
          ),
        ],
      ),
    );
  }

// Było jak poniżej, przerobiłem trochę całość by sensownie umieścić przycisk

/*  @override
  Widget build(BuildContext context) {
    return Material(
        color: kPageBackgroundColor,
        child: ListView(
          children: const [Text('Konto')],
        )
    );
  }*/
}
