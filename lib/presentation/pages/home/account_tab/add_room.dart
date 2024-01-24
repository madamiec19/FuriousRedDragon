import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({Key? key}) : super(key: key);

  static const routeName = '/addRoom';

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  List<String> buildings = ['0', '1', '2', '3'];

  //String selectedBuilding = '';
  String selectedFloor = '';
  //String selectedRoom = '';
  TextEditingController buildingController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  Widget buildStringInput(String label, TextEditingController controller) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 78),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: kGlobalTextStyle.copyWith(fontSize: 18),
            ),
            kBigGap,
            Expanded(
              child: TextFormField(
                controller: controller,
                style: kGlobalTextStyle,
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
      ),
    );
  }

  Widget buildDropdownInput(
    String label,
    List<String> items,
    String selectedItem,
    ValueChanged<String?> onSelect,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 78),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: kGlobalTextStyle.copyWith(fontSize: 18),
            ),
            kBigGap,
            Expanded(
              child: DropdownMenu(
                textStyle: kGlobalTextStyle,
                initialSelection: selectedItem,
                onSelected: (newValue) {
                  onSelect(newValue);
                },
                dropdownMenuEntries:
                    items.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                    style: const ButtonStyle(
                      textStyle: MaterialStatePropertyAll<TextStyle>(
                        kGlobalTextStyle,
                      ),
                    ),
                  );
                }).toList(),
                menuStyle: const MenuStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    kPageBackgroundColor,
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  fillColor: kPageBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          Text('Wybierz salę', style: kGlobalTextStyle.copyWith(fontSize: 28)),
          kBigGap,
          buildStringInput('Budynek:', buildingController),
          buildDropdownInput('Piętro:', buildings, selectedFloor, (newValue) {
            selectedFloor = newValue ?? selectedFloor;
          }),
          buildStringInput('Sala:', roomController),
          kBigGap,
          BigWhiteButton(
            onTap: () {
              print('SelectedBuilding = ${buildingController.text}');
              print('SelectedFloor = $selectedFloor');
              print('SelectedRoom = ${roomController.text}');
            },
            buttonTitle: 'Rozpocznij skanowanie',
          ),
        ],
      ),
    );
  }
}
