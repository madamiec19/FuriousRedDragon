import 'package:flutter/material.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/item_details_page.dart';

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
      body: ListView(
        children: listItems,
      ),
    );
  }
}
