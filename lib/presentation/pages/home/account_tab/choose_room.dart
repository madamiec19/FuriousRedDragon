import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class ChooseRoomPage extends StatefulWidget {
  const ChooseRoomPage({Key? key}) : super(key: key);

  static const routeName = '/choose-room';

  @override
  State<ChooseRoomPage> createState() => _ChooseRoomPageState();
}

class _ChooseRoomPageState extends State<ChooseRoomPage> {
  final String tableName = 'roles'; //zmienić na buildings
  final String columnName = 'name'; //zmienić na number
  List<String> buildings = [];

  @override
  void initState() {
    super.initState();
    // readData();
    selectedBuilding = '';
    selectedFloor = '';
    selectedRoom = '';
  }

  // Future<void> readData() async {
  //    var response = await supabase.from(tableName).select(columnName);
  //    .order('number', ascending: true);
  //   setState(() {
  //     for (Map row in response) {
  //       buildings.add(row[columnName]);
  //     }
  //   });
  // }

  // List<String> buildings = ['34', '38', 'will change lists later'];

  String selectedBuilding = '';
  String selectedFloor = '';
  String selectedRoom = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPageBackgroundColor,
        appBar: AppBar(
          backgroundColor: kFuriousRedColor,
          title: const Text('Wybór sali'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wybierz salę',
                style: kGlobalTextStyle.copyWith(fontSize: 28)),
            kBigGap,
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                  // margin: const EdgeInsets.fromLTRB(0, 20, 0, 60),
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
                        initialSelection: selectedBuilding,
                        onSelected: (newValue) {
                          setState(() {
                            selectedBuilding = newValue ?? selectedBuilding;
                          });
                        },
                        dropdownMenuEntries: buildings
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
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
                    kBigGap
                  ]),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                  // margin: const EdgeInsets.fromLTRB(0, 20, 0, 60),
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
                        enabled: (selectedBuilding != ''),
                        //initialSelection: selectedBuilding,
                        onSelected: (newValue) {
                          setState(() {
                            selectedFloor = newValue ?? selectedFloor;
                          });
                        },
                        dropdownMenuEntries: buildings
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
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
                    kBigGap
                  ]),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                  // margin: const EdgeInsets.fromLTRB(0, 20, 0, 60),
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
                        enabled: (selectedFloor != ''),
                        initialSelection: selectedRoom,
                        onSelected: (newValue) {
                          setState(() {
                            selectedRoom = newValue ?? selectedRoom;
                          });
                        },
                        dropdownMenuEntries: buildings
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
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
                    kBigGap
                  ]),
            ),
            kBigGap,
            BigWhiteButton(
              onTap: () {},
              buttonTitle: 'Rozpocznij skanowanie',
            )
          ],
        ));
  }
}
