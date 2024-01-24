import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/report_overview_page.dart';
import 'package:furious_red_dragon/presentation/pages/home/account_tab/add_report.dart';
import 'package:furious_red_dragon/presentation/pages/home/account_tab/choose_room.dart';
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
            BigWhiteButton(
              onTap: () {
                Navigator.pushNamed(context, AddRoomPage.routeName);
              },
              buttonTitle: 'Dodaj salę',
            ),
            kBigGap,
            state.isReportInitialized()
                ? BigWhiteButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReportOverview(report: state.report)));
                    },
                    buttonTitle: 'Podgląd raportu',
                  )
                : BigRedButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChooseRoomPage()));
                    },
                    buttonTitle: 'Rozpocznij inwentaryzację'),
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
