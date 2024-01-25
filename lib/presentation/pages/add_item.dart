import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/add_edit_item/add_edit_item_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({Key? key}) : super(key: key);

  static const routeName = '/add-item';

  @override
  Widget build(BuildContext context) {
    List<String> states = ['sprawny', 'uszkodzony'];
    return WillPopScope(
      onWillPop: () async {
        context.read<AddEditItemBloc>().add(AddEditItemFinish());

        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: kPageBackgroundColor,
        appBar: AppBar(
          backgroundColor: kFuriousRedColor,
          title: const Text('Dodanie przedmiotu'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: BlocConsumer<AddEditItemBloc, AddEditItemState>(
                listener: (context, state) {
              if (state.isFinished()) {
                //TODO jakiś snackbar
                context.read<AddEditItemBloc>().add(AddEditItemFinish());
                Navigator.pop(context);
              }
            }, builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Wypełnij informacje',
                      style: kGlobalTextStyle.copyWith(fontSize: 28)),
                  kBigGap,
                  Container(
                    color: Colors.white,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 20, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Kod:',
                            style: kGlobalTextStyle.copyWith(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: kGlobalTextStyle,
                            initialValue:
                                state.code.isEmpty ? 'elo' : state.code,
                            onChanged: (value) {
                              context
                                  .read<AddEditItemBloc>()
                                  .add(AddEditItemCodeChanged(code: value));
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: kPageBackgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 20,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Typ:',
                            style: kGlobalTextStyle.copyWith(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: kGlobalTextStyle,
                            initialValue: state.type,
                            onChanged: (value) {
                              context
                                  .read<AddEditItemBloc>()
                                  .add(AddEditItemTypeChanged(type: value));
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: kPageBackgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 20, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Producent:',
                            style: kGlobalTextStyle.copyWith(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: kGlobalTextStyle,
                            initialValue: state.brand ?? '',
                            onChanged: (value) {
                              context
                                  .read<AddEditItemBloc>()
                                  .add(AddEditItemBrandChanged(brand: value));
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: kPageBackgroundColor,
                            ),
                          ),
                        ),
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
                            child: Text('Status:',
                                style: kGlobalTextStyle.copyWith(fontSize: 18)),
                          ),
                          Expanded(
                            flex: 1,
                            child: DropdownMenu(
                              width: kScreenWidth * 0.4,
                              textStyle: kGlobalTextStyle,
                              initialSelection: state.status ?? '',
                              onSelected: (newValue) {
                                context.read<AddEditItemBloc>().add(
                                    AddEditItemStatusChanged(
                                        status: newValue ?? ''));
                              },
                              dropdownMenuEntries: states
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                  value: value,
                                  label: value,
                                  style: const ButtonStyle(
                                    textStyle:
                                        MaterialStatePropertyAll<TextStyle>(
                                            kGlobalTextStyle),
                                  ),
                                );
                              }).toList(),
                              menuStyle: const MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        kPageBackgroundColor),
                              ),
                              inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                fillColor: kPageBackgroundColor,
                              ),
                            ),
                          ),
                          kBigGap
                        ]),
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
                            child: Text('Budynek:',
                                style: kGlobalTextStyle.copyWith(fontSize: 18)),
                          ),
                          Expanded(
                            flex: 1,
                            child: DropdownMenu(
                              width: kScreenWidth * 0.4,
                              textStyle: kGlobalTextStyle,
                              onSelected: (newValue) {
                                context.read<AddEditItemBloc>().add(
                                    AddEditItemBuildingChanged(
                                        idBuilding: newValue as int));
                              },
                              dropdownMenuEntries: state.buildings
                                  .map<DropdownMenuEntry<int>>((int value) {
                                return DropdownMenuEntry<int>(
                                  value: value,
                                  label: value.toString(),
                                  style: const ButtonStyle(
                                    textStyle:
                                        MaterialStatePropertyAll<TextStyle>(
                                            kGlobalTextStyle),
                                  ),
                                );
                              }).toList(),
                              menuStyle: const MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        kPageBackgroundColor),
                              ),
                              inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                fillColor: kPageBackgroundColor,
                              ),
                            ),
                          ),
                          kBigGap
                        ]),
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
                              width: kScreenWidth * 0.4,
                              textStyle: kGlobalTextStyle,
                              enabled: state.isBuildingChosen(),
                              initialSelection: state.isRoomProvided()
                                  ? state.idBuilding
                                  : '',
                              onSelected: (newValue) {
                                context.read<AddEditItemBloc>().add(
                                    AddEditItemFloorChanged(
                                        floor: newValue as int));
                              },
                              dropdownMenuEntries: state.floors
                                  .map<DropdownMenuEntry<int>>((int value) {
                                return DropdownMenuEntry<int>(
                                  value: value,
                                  label: value.toString(),
                                  style: const ButtonStyle(
                                    textStyle:
                                        MaterialStatePropertyAll<TextStyle>(
                                            kGlobalTextStyle),
                                  ),
                                );
                              }).toList(),
                              menuStyle: const MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        kPageBackgroundColor),
                              ),
                              inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                fillColor: kPageBackgroundColor,
                              ),
                            ),
                          ),
                          kBigGap
                        ]),
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
                              width: kScreenWidth * 0.4,
                              textStyle: kGlobalTextStyle,
                              enabled: state.isFloorChosen(),
                              initialSelection:
                                  state.isRoomProvided() ? state.room : '',
                              onSelected: (newValue) {
                                if (newValue is Room) {
                                  context.read<AddEditItemBloc>().add(
                                      AddEditItemRoomChanged(
                                          room: newValue.id));
                                }
                              },
                              dropdownMenuEntries: state.rooms
                                  .map<DropdownMenuEntry<Room>>((Room value) {
                                return DropdownMenuEntry<Room>(
                                  value: value,
                                  label: value.toString(),
                                  style: const ButtonStyle(
                                    textStyle:
                                        MaterialStatePropertyAll<TextStyle>(
                                            kGlobalTextStyle),
                                  ),
                                );
                              }).toList(),
                              menuStyle: const MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        kPageBackgroundColor),
                              ),
                              inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                fillColor: kPageBackgroundColor,
                              ),
                            ),
                          ),
                          kBigGap
                        ]),
                  ),
                  kBigGap,
                  BigWhiteButton(
                    onTap: () {
                      context
                          .read<AddEditItemBloc>()
                          .add(AddEditItemButtonClicked());
                    },
                    buttonTitle: 'Rozpocznij skanowanie',
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
