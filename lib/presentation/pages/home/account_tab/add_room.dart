import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/add_room/add_room_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class AddRoomPage extends StatelessWidget {
  const AddRoomPage({Key? key}) : super(key: key);

  static const routeName = '/add-room';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      appBar: AppBar(
        title: const Text('Dodawanie sali'),
        backgroundColor: kFuriousRedColor,
      ),
      body: BlocConsumer<AddRoomBloc, AddRoomState>(
        listener: (context, state) {
          if (state.isAdded()) {
            context.read<AddRoomBloc>().add(AddRoomInitial());
            //TODO snackbar że dodano pomieszczenie
            Navigator.pop(context);
          }
        },
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wypełnij pola',
                style: kGlobalTextStyle.copyWith(fontSize: 28)),
            kBigGap,
            const _BuildingInputField(),
            const _FloorInputField(),
            const _RoomInputField(),
            kBigGap,
            BigWhiteButton(
              enabled: state.isAllFilled(),
              onTap: () {
                context.read<AddRoomBloc>().add(AddRoomButtonClicked());
              },
              buttonTitle: 'Dodaj salę',
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildingInputField extends StatelessWidget {
  const _BuildingInputField();

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              // onSelected: (value) {
              //   context
              //       .read<AddRoomBloc>()
              //       .add(AddRoomBuildingEdited(building: value));
              // },
              dropdownMenuEntries: const [],
              menuStyle: const MenuStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(kPageBackgroundColor),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: kPageBackgroundColor,
              ),
            ),
          ),
          kBigGap
        ]),
      );
}

class _FloorInputField extends StatelessWidget {
  const _FloorInputField();

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          kBigGap,
          Expanded(
            flex: 1,
            child:
                Text('Piętro:', style: kGlobalTextStyle.copyWith(fontSize: 18)),
          ),
          Expanded(
            flex: 1,
            child: DropdownMenu(
              width: kScreenWidth * 0.4,
              textStyle: kGlobalTextStyle,
              // onSelected: (value) {
              //   context
              //       .read<AddRoomBloc>()
              //       .add(AddRoomFloordited(floor: value));
              // },
              dropdownMenuEntries: const [],
              menuStyle: const MenuStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(kPageBackgroundColor),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: kPageBackgroundColor,
              ),
            ),
          ),
          kBigGap
        ]),
      );
}

class _RoomInputField extends StatelessWidget {
  const _RoomInputField();

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          kBigGap,
          Expanded(
            flex: 1,
            child:
                Text('Sala:', style: kGlobalTextStyle.copyWith(fontSize: 18)),
          ),
          Expanded(
            flex: 1,
            child: DropdownMenu(
              width: kScreenWidth * 0.4,
              textStyle: kGlobalTextStyle,
              // onSelected: (value) {
              //   context
              //       .read<AddRoomBloc>()
              //       .add(AddRoomRoomEdited(room: value));
              // },
              dropdownMenuEntries: const [],
              menuStyle: const MenuStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(kPageBackgroundColor),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: kPageBackgroundColor,
              ),
            ),
          ),
          kBigGap
        ]),
      );
}
