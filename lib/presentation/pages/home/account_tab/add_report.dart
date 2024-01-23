import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/add_report/add_report_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class AddReportPage extends StatelessWidget {
  const AddReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AddReportBloc, AddReportState>(
        listener: (context, state) {
          /// Obserwacja zmian stanu
          /// Jeśli stan to 'dodano nowy raport', aktywuj event z [ReportBloc]- inicjacja inwentaryzacji wybranego pomieszczenia
          if (state.isAdded()) {
            context
                .read<ReportBloc>()
                .add(ReportInitialized(idRoom: state.chosenRoom.id));
            context.read<AddReportBloc>().add(AddReportInitial());
            Navigator.pop(context);
          }
        },
        child:

            /// BlocBuilder umożliwia dostęp do stanu, przebudowywuje UI gdy stan ulegnie zmianie
            BlocBuilder<AddReportBloc, AddReportState>(
                builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Wybierz budynek'),
                DropdownMenu(
                  textStyle: kGlobalTextStyle,
                  onSelected: (newValue) {
                    /// Aktywacja eventu 'wybrano budynek'
                    context
                        .read<AddReportBloc>()
                        .add(AddReportBuildingChosen(building: newValue ?? -1));
                  },
                  dropdownMenuEntries:

                      /// Wypełnianie pola wyboru budynku na podstawie stanu (state.buildings: List<int>)
                      state.buildings.map<DropdownMenuEntry<int>>((int value) {
                    return DropdownMenuEntry<int>(
                        value: value,
                        label: value.toString(),
                        style: const ButtonStyle(
                            textStyle: MaterialStatePropertyAll<TextStyle>(
                                kGlobalTextStyle)));
                  }).toList(),
                  menuStyle: const MenuStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(kPageBackgroundColor),
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    fillColor: kPageBackgroundColor,
                  ),
                ),
                kBigGap,
                const Text('Wybierz pomieszczenie'),
                DropdownMenu(
                  /// [DropdownMenu] jest aktywne gdy budynek został wybrany
                  enabled: state.isBuildingChosen(),
                  textStyle: kGlobalTextStyle,
                  onSelected: (newValue) {
                    /// Aktywacja eventu 'wybrano pomieszczenie'
                    context
                        .read<AddReportBloc>()
                        .add(AddReportRoomChosen(room: newValue ?? Room.empty));
                  },
                  dropdownMenuEntries:

                      /// Wypełnianie pola wyboru budynku na podstawie stanu (state.rooms: List<Room>)
                      state.rooms.map<DropdownMenuEntry<Room>>((Room value) {
                    return DropdownMenuEntry<Room>(
                        value: value,
                        label: value.toString(),
                        style: const ButtonStyle(
                            textStyle: MaterialStatePropertyAll<TextStyle>(
                                kGlobalTextStyle)));
                  }).toList(),
                  menuStyle: const MenuStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(kPageBackgroundColor),
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    fillColor: kPageBackgroundColor,
                  ),
                ),
                kBigGap,
                BigWhiteButton(

                    /// Przycisk jest aktywny gdy pomieszczenie zostało wybrane
                    enabled: state.isRoomChosen(),
                    onTap: () {
                      /// Aktywacja eventu 'wcisnieto przycisk '
                      context
                          .read<AddReportBloc>()
                          .add(AddReportButtonClicked());
                    },
                    buttonTitle: 'Rozpocznij')
              ],
            ),
          );
        }),
      ),
    );
  }
}
