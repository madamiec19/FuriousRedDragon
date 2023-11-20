import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/components/white_card.dart';
import '../../constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum View { history, database }

final _supabase = Supabase.instance.client;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  View selectedView = View.history;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPageBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: DoubleButton(
              onFirstOptionChosen: () {
                setState(() {
                  selectedView = View.history;
                });
              },
              onSecondOptionChosen: () {
                setState(() {
                  selectedView = View.database;
                });
              },
              leftOptionLabel: 'Historia',
              rightOptionLabel: 'Baza danych',
            ),
          ),
          if (selectedView == View.history)
            const Expanded(
              child: WhiteCard(
                child: ReportsStream(),
              ),
            )
          else if (selectedView == View.database)
            const Expanded(
              child: WhiteCard(
                child: Text('Baza danych'),
              ),
            )
        ],
      ),
    );
  }
}

class ReportsStream extends StatefulWidget {
  const ReportsStream({super.key});

  @override
  State<ReportsStream> createState() => _ReportsStreamState();
}

class _ReportsStreamState extends State<ReportsStream> {
  final _stream = _supabase.from('reports').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: kFuriousRedColor,
                backgroundColor: kLightGrey,
              ),
            );
          }
          final reports = snapshot.data;
          List<ReportListItem> reportListItems = [];
          for (var report in reports!) {
            final room = report['room'];
            final author = report['author'];
            final reportString = room + ', ' + author;
            reportListItems.add(ReportListItem(
              onTap: () {},
              buttonTitle: reportString,
            ));
          }
          return ListView(
            children: reportListItems,
          );
        });
  }
}
