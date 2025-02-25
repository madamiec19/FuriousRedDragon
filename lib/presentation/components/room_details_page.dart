import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/add_edit_item/add_edit_item_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/item_details_page.dart';
import 'package:furious_red_dragon/presentation/pages/add_item.dart';

class RoomDetailsPage extends StatefulWidget {
  final Room room;
  const RoomDetailsPage({super.key, required this.room});

  @override
  State<RoomDetailsPage> createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  @override
  Widget build(BuildContext context) {
    List<Item> items = widget.room.items;
    List<BasicListItem> listItems = [];
    for (var item in items) {
      listItems.add(BasicListItem(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemDetailsPage(item: item)));
          },
          buttonTitle: item.toString()));
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sala ${widget.room.toString()}',
            style: const TextStyle(fontSize: 24),
          ),
          kSmallGap,
          const Text('Lista przedmiotów'),
          kSmallGap,
          Expanded(
            child: ListView(
              children: listItems.isEmpty
                  ? [const Center(child: Text('brak przedmiotów w sali'))]
                  : listItems,
            ),
          ),
          Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmallButton(
                      onTap: () {
                        context
                            .read<AddEditItemBloc>()
                            .add(AddEditItemAddFromRoom(room: widget.room));
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddItemPage()));
                      },
                      buttonTitle: 'Dodaj przedmiot'),
                  SmallButton(onTap: () {}, buttonTitle: 'Pokaż raporty')
                ],
              )),
        ],
      ),
    );
  }
}
