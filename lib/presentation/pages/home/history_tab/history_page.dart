import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/history_database/history_database_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/room_details_page.dart';
import 'package:furious_red_dragon/presentation/components/white_card.dart';
import 'package:furious_red_dragon/presentation/components/report_overview_page.dart';
import 'package:furious_red_dragon/presentation/pages/home/history_tab/add_user_screen.dart';
import 'package:furious_red_dragon/presentation/pages/home/history_tab/rooms_stream.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/presentation/pages/home/history_tab/users_stream.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<HistoryDatabaseBloc>()
        .add(HistoryDatabaseInitialCheckRequest());
    return BlocListener<HistoryDatabaseBloc, HistoryDatabaseState>(
      listener: (BuildContext context, HistoryDatabaseState state) {
        if (state.isAddUserViewChosen()) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddUserPage()),
          );
        }
      },
      child: Material(
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
              /// gdy wybrane jest menu historia wyświetlane są raporty
              if (state.isHistoryMenuChosen()) {
                List<Report> reports = state.reports;
                List<BasicListItem> items = [];
                if (reports.isNotEmpty) {
                  for (var report in reports) {
                    items.add(BasicListItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReportOverview(report: report)));
                        },
                        buttonTitle: report.toString()));
                  }
                }
                return Expanded(
                  child: WhiteCard(
                    child: items.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: kFuriousRedColor,
                              backgroundColor: kLightGrey,
                            ),
                          )
                        : ListView(
                            children: items,
                          ),
                  ),
                );
              }

              /// gdy wybrane jest menu baza danych, różny content jest wyświetlany dla admina a inny dla pracownika
              else if (state.isDatabaseMenuChosen()) {
                return state.isAdmin
                    ? const AdminDatabaseMenu()
                    : const Expanded(
                        child: WhiteCard(
                          child: RoomsStream(),
                        ),
                      );
              } else if (state.isLocalizationsViewChosen()) {
                List<Room> rooms = state.rooms;
                List<BasicListItem> items = [];
                if (rooms.isNotEmpty) {
                  for (var room in rooms) {
                    items.add(BasicListItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RoomDetailsPage(room: room)));
                        },
                        buttonTitle: room.toString()));
                  }
                }
                return Expanded(
                  child: WhiteCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                height: 43,
                                width: 43,
                                child: IconButton(
                                  style: const ButtonStyle(
                                    iconColor:
                                        MaterialStatePropertyAll(Colors.white),
                                    backgroundColor: MaterialStatePropertyAll(
                                        kFuriousRedColor),
                                  ),
                                  onPressed: () => context
                                      .read<HistoryDatabaseBloc>()
                                      .add(HistoryDatabaseDatabaseMenuChosen()),
                                  icon: const Icon(
                                    Icons.west,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                            child: ListView(
                          children: items,
                        )),
                      ],
                    ),
                  ),
                );
              } else if (state.isUsersViewChosen()) {
                return Expanded(
                  child: WhiteCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: IconButton(
                                  style: const ButtonStyle(
                                    iconColor:
                                        MaterialStatePropertyAll(Colors.white),
                                    backgroundColor: MaterialStatePropertyAll(
                                        kFuriousRedColor),
                                  ),
                                  onPressed: () => context
                                      .read<HistoryDatabaseBloc>()
                                      .add(HistoryDatabaseDatabaseMenuChosen()),
                                  icon: const Icon(
                                    Icons.west,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const UsersStream(),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                context
                                    .read<HistoryDatabaseBloc>()
                                    .add(HistoryAdminAddUserButtonClicked());
                              },
                              icon: const Icon(Icons.add_circle_outline),
                              iconSize: 37,
                            ),
                            const Text('Dodaj użytkownika'),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const WhiteCard(child: Text(''));
              }
            })
          ],
        ),
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
                  if (state.isDatabaseMenuChosen() ||
                      state.isLocalizationsViewChosen() ||
                      state.isUsersViewChosen()) {
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
              height: state.isDatabaseMenuChosen() ||
                      state.isLocalizationsViewChosen() ||
                      state.isUsersViewChosen()
                  ? 46
                  : 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: (state.isDatabaseMenuChosen() ||
                          state.isLocalizationsViewChosen() ||
                          state.isUsersViewChosen())
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
                    context
                        .read<HistoryDatabaseBloc>()
                        .add(HistoryDatabaseAdminLocalizationsButtonClicked());
                  },
                ),
              ),
              kBigGap,
              SizedBox(
                  width: kScreenWidth,
                  child: BigWhiteButton(
                      onTap: () {
                        context
                            .read<HistoryDatabaseBloc>()
                            .add(HistoryAdminUsersButtonClicked());
                      },
                      buttonTitle: 'Użytkownicy')),
            ],
          ),
        ),
      ),
    );
  }
}
