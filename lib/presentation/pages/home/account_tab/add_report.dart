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
    context.read<AddReportBloc>().add(AddReportInitial());
    return WillPopScope(
      onWillPop: () async {
        context.read<AddReportBloc>().add(AddReportInitial());
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: kPageBackgroundColor,
        appBar: AppBar(title: const Text('Rozpoczynanie inwentaryzacji')),
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Wybierz salę',
                    style: kGlobalTextStyle.copyWith(fontSize: 28)),
                kBigGap,
                Container(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kBigGap,
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Budynek:',
                          style: kGlobalTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownMenu(
                          width: kScreenWidth * 0.4,
                          textStyle: kGlobalTextStyle,
                          onSelected: (newValue) {
                            /// Aktywacja eventu 'wybrano budynek'
                            context.read<AddReportBloc>().add(
                                AddReportBuildingChosen(
                                    building: newValue ?? -1));
                          },
                          dropdownMenuEntries:

                              /// Wypełnianie pola wyboru budynku na podstawie stanu (state.buildings: List<int>)
                              state.buildings
                                  .map<DropdownMenuEntry<int>>((int value) {
                            return DropdownMenuEntry<int>(
                                value: value,
                                label: value.toString(),
                                style: const ButtonStyle(
                                    textStyle:
                                        MaterialStatePropertyAll<TextStyle>(
                                            kGlobalTextStyle)));
                          }).toList(),
                          menuStyle: const MenuStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                kPageBackgroundColor),
                          ),
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            fillColor: kPageBackgroundColor,
                          ),
                        ),
                      ),
                      kBigGap,
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kBigGap,
                      Expanded(
                        flex: 1,
                        child: Text('Piętro:',
                            style: kGlobalTextStyle.copyWith(fontSize: 18)),
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownMenu(
                          /// [DropdownMenu] jest aktywne gdy budynek został wybrany
                          enabled: state.isBuildingChosen(),
                          width: kScreenWidth * 0.4,
                          textStyle: kGlobalTextStyle,
                          onSelected: (newValue) {
                            /// Aktywacja eventu 'wybrano piętro'
                            context.read<AddReportBloc>().add(
                                AddReportFloorChosen(floor: newValue ?? -3));
                          },
                          dropdownMenuEntries:

                              /// Wypełnianie pola wyboru budynku na podstawie stanu (state.rooms: List<Room>)
                              state.floors
                                  .map<DropdownMenuEntry<int>>((int value) {
                            return DropdownMenuEntry<int>(
                                value: value,
                                label: value.toString(),
                                style: const ButtonStyle(
                                    textStyle:
                                        MaterialStatePropertyAll<TextStyle>(
                                            kGlobalTextStyle)));
                          }).toList(),
                          menuStyle: const MenuStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                kPageBackgroundColor),
                          ),
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            fillColor: kPageBackgroundColor,
                          ),
                        ),
                      ),
                      kBigGap,
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kBigGap,
                      Expanded(
                        flex: 1,
                        child: Text('Sala:',
                            style: kGlobalTextStyle.copyWith(fontSize: 18)),
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownMenu(
                          /// [DropdownMenu] jest aktywne gdy budynek został wybrany
                          enabled:
                              state.isFloorChosen() && state.isBuildingChosen(),
                          width: kScreenWidth * 0.4,
                          textStyle: kGlobalTextStyle,
                          onSelected: (newValue) {
                            /// Aktywacja eventu 'wybrano pomieszczenie'
                            context.read<AddReportBloc>().add(
                                AddReportRoomChosen(
                                    room: newValue ?? Room.empty));
                          },
                          dropdownMenuEntries:

                              /// Wypełnianie pola wyboru budynku na podstawie stanu (state.rooms: List<Room>)
                              state.rooms
                                  .map<DropdownMenuEntry<Room>>((Room value) {
                            return DropdownMenuEntry<Room>(
                                value: value,
                                label: value.name.toString(),
                                style: const ButtonStyle(
                                    textStyle:
                                        MaterialStatePropertyAll<TextStyle>(
                                            kGlobalTextStyle)));
                          }).toList(),
                          menuStyle: const MenuStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                kPageBackgroundColor),
                          ),
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            fillColor: kPageBackgroundColor,
                          ),
                        ),
                      ),
                      kBigGap,
                    ],
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
            );
          }),
        ),
      ),
    );
  }
}
