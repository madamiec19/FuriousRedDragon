import 'package:flutter/material.dart';
import 'package:furious_red_dragon/presentation/components/white_card.dart';
import 'package:furious_red_dragon/data/models/item.dart';
import 'package:furious_red_dragon/presentation/pages/home/history_tab/rooms_stream.dart';

import '../../../components/buttons.dart';
import 'package:furious_red_dragon/core/constants.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key});

  static const routeName = '/roomDetails';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const WhiteCard(
        child: ItemsStreamView(),
      ),
    );
  }
}

class ItemsStreamView extends StatefulWidget {
  const ItemsStreamView({super.key});

  @override
  State<ItemsStreamView> createState() => _ItemsStreamViewState();
}

class _ItemsStreamViewState extends State<ItemsStreamView> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    final stream = client
        .from('items')
        .stream(primaryKey: ['id']).eq('id_room', args.selectedRoomId);

    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: kFuriousRedColor,
                backgroundColor: kLightGrey,
              ),
            );
          }
          final items = snapshot.data;
          List<BasicListItem> itemsListItems = [];
          for (var item in items!) {
            Item newItem = Item(
              type: item['type'],
              brand: item['brand'],
              barcode: item['serial_number'],
              id: item['id'],
              idRoom: item['id_room'],
              state: item['state'],
            );
            itemsListItems.add(BasicListItem(
              onTap: () {},
              buttonTitle: newItem.toString(),
            ));
          }
          return ListView(
            children: itemsListItems,
          );
        });
  }
}
