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
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                kBigGap,
                Expanded(
                  flex: 1,
                  child: Text(
                    'Kod:',
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
            ),
            const Column(
              children: [
                _CodeInputField(),
                kSmallGap,
                // _PasswordInputField(),
                // kBigGap,
                // _LoginButton()
              ],
            ),
          ],
        ));
  }
}

class _CodeInputField extends StatelessWidget {
  const _CodeInputField();

  @override
  Widget build(BuildContext context) => Container(
        margin: kSplashInputMargin.copyWith(bottom: 20),
        decoration: kCredentialsTextFieldContainerDecoration,
        child: BlocBuilder<LoginBloc, Ad>(
          buildWhen: (previous, current) => current.email != previous.email,
          builder: (context, state) => TextField(
            // onChanged: (email) =>
            //     context.read<LoginBloc>().add(LoginEmailAddressChanged(email)),
            decoration: kCredentialsTextFieldInputDecoration.copyWith(
              labelText: 'email',
              errorText: state.email.hasError
                  ? state.email.errorMessage.toString()
                  : null,
            ),
            style: kCredentialsTextStyle,
            cursorColor: kFuriousRedColor,
          ),
        ),
      );
}
