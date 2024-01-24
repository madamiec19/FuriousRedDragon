import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/login/login_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  static const routeName = '/add-item';

  @override
  State<AddItemPage> createState() => _ChooseRoomPageState();
}

class _ChooseRoomPageState extends State<AddItemPage> {
  final String tableName = 'roles';
  final String columnName = 'name';
  List<String> buildings = [];

  @override
  void initState() {
    super.initState();
    // readData();
    selectedBuilding = '';
    selectedFloor = '';
    selectedRoom = '';
  }

  String selectedBuilding = '';
  String selectedFloor = '';
  String selectedRoom = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPageBackgroundColor,
        appBar: AppBar(
          backgroundColor: kFuriousRedColor,
          title: const Text('Dodanie przedmiotu'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wypełnij informacje',
                style: kGlobalTextStyle.copyWith(fontSize: 28)),
            kBigGap,
            const _CodeInputField(),
            const _TypeInputField(),
            const _ProducerInputField(),
            const _FloorInputField(),
            const _RoomInputField(),
            kBigGap,
            BigWhiteButton(
              onTap: () {},
              buttonTitle: 'Rozpocznij skanowanie',
            ),
          ],
        ));
  }
}

class _CodeInputField extends StatelessWidget {
  const _CodeInputField();

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
            kBigGap,
            Expanded(
              flex: 1,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: kGlobalTextStyle,
                // onChanged: (value) {
                //   context
                //       .read<AddRoomBloc>()
                //       .add(AddRoomRoomEdited(room: value));
                // },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kPageBackgroundColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _TypeInputField extends StatelessWidget {
  const _TypeInputField();

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
            kBigGap,
            Expanded(
              flex: 1,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: kGlobalTextStyle,
                // onChanged: (value) {
                //   context
                //       .read<AddRoomBloc>()
                //       .add(AddRoomRoomEdited(room: value));
                // },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kPageBackgroundColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _ProducerInputField extends StatelessWidget {
  const _ProducerInputField();

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
            kBigGap,
            Expanded(
              flex: 1,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: kGlobalTextStyle,
                // onChanged: (value) {
                //   context
                //       .read<AddRoomBloc>()
                //       .add(AddRoomRoomEdited(room: value));
                // },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kPageBackgroundColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
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
              // enabled: (selectedBuilding != ''),
              //initialSelection: selectedBuilding,
              // onSelected: (newValue) {
              //   setState(() {
              //     selectedFloor = newValue ?? selectedFloor;
              //   });
              // },
              dropdownMenuEntries: const [],
              //     buildings.map<DropdownMenuEntry<String>>((String value) {
              //   return DropdownMenuEntry<String>(
              //     value: value,
              //     label: value,
              //     style: const ButtonStyle(
              //       textStyle:
              //           MaterialStatePropertyAll<TextStyle>(kGlobalTextStyle),
              //     ),
              //   );
              // }).toList(),
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
              // enabled: (selectedBuilding != ''),
              //initialSelection: selectedBuilding,
              // onSelected: (newValue) {
              //   setState(() {
              //     selectedFloor = newValue ?? selectedFloor;
              //   });
              // },
              dropdownMenuEntries: const [],
              //     buildings.map<DropdownMenuEntry<String>>((String value) {
              //   return DropdownMenuEntry<String>(
              //     value: value,
              //     label: value,
              //     style: const ButtonStyle(
              //       textStyle:
              //           MaterialStatePropertyAll<TextStyle>(kGlobalTextStyle),
              //     ),
              //   );
              // }).toList(),
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
