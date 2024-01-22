import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/auth_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/report_overview_page.dart';
import 'add_room.dart';
import 'package:furious_red_dragon/core/constants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPageBackgroundColor,
      child: BlocBuilder<ReportBloc, ReportState>(builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.isReportInitialized()
                ? Text('Id aktywnego raportu: ' + state.report.id.toString())
                : Text(''),
            BigWhiteButton(
              onTap: () {
                Navigator.pushNamed(context, AddRoomPage.routeName);
              },
              buttonTitle: 'Dodaj salę',
            ),
            kBigGap,
            Text('PRZYCISKI TESTOWE'),
            kSmallGap,
            BigWhiteButton(
              onTap: () {
                final authstate = BlocProvider.of<AuthBloc>(context).state;
                if (authstate is AuthUserAuthenticated) {
                  context.read<ReportBloc>().add(ReportInitialized(
                      idAuthor: authstate.userId,
                      createdAt: DateTime.now(),
                      idRoom: 1));
                }
              },
              buttonTitle: 'inicjalizacja raportu dla pomieszczenia o id 1',
            ),
            kBigGap,
            BigWhiteButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ReportOverview(report: state.report)));
              },
              buttonTitle: 'podgląd raportu',
            ),
            kBigGap,
            BigWhiteButton(
              onTap: () {
                context.read<ReportBloc>().add(ReportFinished());
              },
              buttonTitle: 'zakonczenie raportu',
            ),
          ],
        );
      }),
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
