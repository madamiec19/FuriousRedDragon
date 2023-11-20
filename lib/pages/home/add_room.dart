import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';

import '../../constants.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key});

  static const routeName = '/addRoom';

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  List<String> buildings = ['34', '38'];

  String selectedBuilding = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPageBackgroundColor,
        appBar: AppBar(
          backgroundColor: kFuriousRedColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Wybierz salę',
              style: //kGlobalTextStyle
                  TextStyle(
                fontSize: 28,
              ),
            ),
            kBigGap,
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                  // margin: const EdgeInsets.fromLTRB(0, 20, 0, 60),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Budynek:'),
                    kBigGap,
                    DropdownMenu(
                      initialSelection: selectedBuilding,
                      onSelected: (newValue) {
                        setState(() {
                          selectedBuilding = newValue ?? selectedBuilding;
                        });
                      },
                      dropdownMenuEntries: buildings
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
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
                  ]),
            ),
            const Row(
              children: [],
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
