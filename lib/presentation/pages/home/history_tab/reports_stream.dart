import 'package:flutter/material.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';

class ReportsStream extends StatefulWidget {
  const ReportsStream({super.key});

  @override
  State<ReportsStream> createState() => _ReportsStreamState();
}

class _ReportsStreamState extends State<ReportsStream> {
  final _stream = client.from('reports').stream(primaryKey: ['id']);

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
            Report newReport = Report(
                id: report['id'],
                createdAt: report['created_at'],
                roomId: report['room_id'],
                idAuthor: report['author_id'],
                scannedItems: [],
                isCompleted: false);
            reportListItems.add(BasicListItem(
              onTap: () {},
              buttonTitle: newReport.toString(),
            ));
          }
          return ListView(
            children: reportListItems,
          );
        });
  }
}
