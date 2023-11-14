import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';

import '../../constants.dart';

class AddRoomPage extends StatelessWidget {
  AddRoomPage({super.key});

  static const routeName = '/addRoom';



  List<String> buildings = ['34', '38'];
  String selectedBuilding = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPageBackgroundColor,
        appBar: AppBar(
          backgroundColor: kFuriousRedColor,
        ),
        body: Center(
            //tutaj ewentualnie można dać Center widget
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Wybierz salę',
                    style: //kGlobalTextStyle
                        TextStyle(
                            fontSize: 28,
                        ),
                  ),
                   Row(
                    // margin: const EdgeInsets.fromLTRB(0, 20, 0, 60),
                    children: [
                      const Text('Budynek:'),
                      /*DropdownButton(
                        value: selectedBuilding,
                        onChanged: (newValue) {
                          setState(() {
                            selectedBuilding = newValue;
                          });
                        },
                        items: buildings.map<DropdownMenuItem<String>>((String selectedBuilding) {
                          return DropdownMenuItem<String>(
                            value: selectedBuilding,
                            child: Text(selectedBuilding),
                          );
                        }).toList(),
                        hint: Text("  Select Gender  "),
                      ),*/
                                          ]

                  ),
                  const Row(
                    children: [],
                  ),
                  BigWhiteButton(
                    onTap: () {},
                    buttonTitle: 'Rozpocznij skanowanie',

                  )
                ],
              )
            ));
  }
/*  @override
  Widget build(BuildContext context) {
    return Material(
        color: kPageBackgroundColor,
        child: ListView(
          children: const [Text('Konto')],
        )
    );
  }*/
}
