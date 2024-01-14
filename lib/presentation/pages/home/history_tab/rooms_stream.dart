import 'package:flutter/material.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/core/constants.dart';

class ScreenArguments {
  final int selectedRoomId;
  ScreenArguments(this.selectedRoomId);
}

class RoomsStream extends StatefulWidget {
  const RoomsStream({super.key});

  @override
  State<RoomsStream> createState() => _RoomsStreamState();
}

class _RoomsStreamState extends State<RoomsStream> {
  final _stream = client.from('rooms').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: kFuriousRedColor,
                backgroundColor: kLightGrey,
              ),
            );
          }
          final rooms = snapshot.data;
          List<BasicListItem> reportListItems = [];
          for (var room in rooms!) {
            final name = room['name'];
            final building = room['id_building'];
            final floor = room['floor'];
            final roomString = 'Sala $floor/$name p.$floor, bud. $building';
            reportListItems.add(BasicListItem(
              onTap: () {
                //TODO
              },
              buttonTitle: roomString,
            ));
          }
          return ListView(
            children: reportListItems,
          );
        });
  }
}
