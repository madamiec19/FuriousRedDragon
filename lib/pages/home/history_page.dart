import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/buttons.dart';
import 'package:furious_red_dragon/components/white_card.dart';
import '../../constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum View { history, database, details }

int selectedRoomId = 0;

final _supabase = Supabase.instance.client;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  View selectedView = View.history;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPageBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: DoubleButton(
              onFirstOptionChosen: () {
                setState(() {
                  selectedView = View.history;
                });
              },
              onSecondOptionChosen: () {
                setState(() {
                  selectedView = View.database;
                });
              },
              leftOptionLabel: 'Historia',
              rightOptionLabel: 'Baza danych',
            ),
          ),
          if (selectedView == View.history)
            const Expanded(
              child: WhiteCard(
                child: ReportsStream(),
              ),
            )
          else if (selectedView == View.database)
            const Expanded(
              child: WhiteCard(
                child: RoomsStream(),
              ),
            )
        ],
      ),
    );
  }
}

class ReportsStream extends StatefulWidget {
  const ReportsStream({super.key});

  @override
  State<ReportsStream> createState() => _ReportsStreamState();
}

class _ReportsStreamState extends State<ReportsStream> {
  final _stream = _supabase.from('reports').stream(primaryKey: ['id']);

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
          final reports = snapshot.data;
          List<BasicListItem> reportListItems = [];
          for (var report in reports!) {
            final room = report['room'];
            final author = report['author'];
            final reportString = room + ', ' + author;
            reportListItems.add(BasicListItem(
              onTap: () {},
              buttonTitle: reportString,
            ));
          }
          return ListView(
            children: reportListItems,
          );
        });
  }
}

class RoomsStream extends StatefulWidget {
  const RoomsStream({super.key});

  @override
  State<RoomsStream> createState() => _RoomsStreamState();
}

class _RoomsStreamState extends State<RoomsStream> {
  final _stream = _supabase.from('rooms').stream(primaryKey: ['id']);

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
                selectedRoomId = room['id'];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RoomDetailsScreen()));
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

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const WhiteCard(
        child: ItemsStream(),
      ),
    );
  }
}

class ItemsStream extends StatefulWidget {
  const ItemsStream({super.key});

  @override
  State<ItemsStream> createState() => _ItemsStreamState();
}

class _ItemsStreamState extends State<ItemsStream> {
  final _stream = _supabase
      .from('items')
      .stream(primaryKey: ['id']).eq('id_room', selectedRoomId);
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
          final items = snapshot.data;
          List<BasicListItem> itemsListItems = [];
          for (var item in items!) {
            final type = item['type'];
            final brand = item['brand'];
            final serialNumber = item['serial_number'];
            final reportString = type + ' ' + brand;
            itemsListItems.add(BasicListItem(
              onTap: () {},
              buttonTitle: reportString,
            ));
          }
          return ListView(
            children: itemsListItems,
          );
        });
  }
}
