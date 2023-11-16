import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/components/white_card.dart';
import '../../constants.dart';

enum View { history, database }

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
                child: Text('Historia'),
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
