import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/history_database/history_database_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/white_card.dart';
import 'package:furious_red_dragon/presentation/pages/home/history_tab/reports_stream.dart';
import 'package:furious_red_dragon/presentation/pages/home/history_tab/rooms_stream.dart';
import 'package:furious_red_dragon/core/constants.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPageBackgroundColor,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: DoubleButton(
              leftOptionLabel: 'Historia',
              rightOptionLabel: 'Baza danych',
            ),
          ),
          BlocBuilder<HistoryDatabaseBloc, HistoryDatabaseState>(
              builder: (context, state) {
            if (state.isHistoryMenuChosen()) {
              return const Expanded(
                child: WhiteCard(
                  child: ReportsStream(),
                ),
              );
            } else if (state.isDatabaseMenuChosen()) {
              return state.isAdmin
                  ? const RoomsStream()
                  : const AdminDatabaseMenu();
            } else {
              return const WhiteCard(child: Text(''));
            }
          })
        ],
      ),
    );
  }
}

class DoubleButton extends StatelessWidget {
  const DoubleButton(
      {super.key,
      this.activeColor = Colors.white,
      this.inactiveColor = kLightGrey,
      required this.leftOptionLabel,
      required this.rightOptionLabel});

  final Color activeColor;
  final Color inactiveColor;
  final String leftOptionLabel;
  final String rightOptionLabel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryDatabaseBloc, HistoryDatabaseState>(
      builder: (context, state) => Row(
        children: [
          Expanded(
            child: SizedBox(
              height: state.isHistoryMenuChosen() ? 46 : 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      state.isHistoryMenuChosen() ? activeColor : inactiveColor,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                onPressed: () {
                  if (state.isDatabaseMenuChosen()) {
                    context
                        .read<HistoryDatabaseBloc>()
                        .add(HistoryDatabaseHistoryMenuChosen());
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    leftOptionLabel,
                    style: kGlobalTextStyle.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: state.isDatabaseMenuChosen() ? 46 : 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: state.isDatabaseMenuChosen()
                      ? activeColor
                      : inactiveColor,
                  maximumSize: const Size(300, 100),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                onPressed: () {
                  if (state.isHistoryMenuChosen()) {
                    context
                        .read<HistoryDatabaseBloc>()
                        .add(HistoryDatabaseDatabaseMenuChosen());
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    rightOptionLabel,
                    style: kGlobalTextStyle.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminDatabaseMenu extends StatelessWidget {
  const AdminDatabaseMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WhiteCard(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Wybierz bazę',
                style: TextStyle(fontSize: 20),
              ),
              kBigGap,
              SizedBox(
                width: kScreenWidth,
                child: BigWhiteButton(
                  buttonTitle: 'Lokalizacje',
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const RoomsScreen()));
                  },
                ),
              ),
              kBigGap,
              SizedBox(
                  width: kScreenWidth,
                  child: BigWhiteButton(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const UsersScreen()));
                      },
                      buttonTitle: 'Użytkownicy')),
            ],
          ),
        ),
      ),
    );
  }
}
