import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/add_room/add_room_bloc.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({Key? key}) : super(key: key);

  static const routeName = '/add-item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackgroundColor,
      appBar: AppBar(
        title: const Text('Dodawanie przedmiotu'),
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
            Container(
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
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Budynek',
                        style: kGlobalTextStyle.copyWith(fontSize: 18),
                      ),
                    ),
                    kBigGap,
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: kGlobalTextStyle,
                        onChanged: (value) {
                          context
                              .read<AddRoomBloc>()
                              .add(AddRoomBuildingEdited(building: value));
                        },
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
            ),
            Container(
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
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Piętro',
                        style: kGlobalTextStyle.copyWith(fontSize: 18),
                      ),
                    ),
                    kBigGap,
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: kGlobalTextStyle,
                        onChanged: (value) {
                          context
                              .read<AddRoomBloc>()
                              .add(AddRoomFloorEdited(floor: value));
                        },
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
            ),
            Container(
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
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Sala',
                        style: kGlobalTextStyle.copyWith(fontSize: 18),
                      ),
                    ),
                    kBigGap,
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: kGlobalTextStyle,
                        onChanged: (value) {
                          context
                              .read<AddRoomBloc>()
                              .add(AddRoomRoomEdited(room: value));
                        },
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
            ),
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
