import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:furious_red_dragon/presentation/components/item_details_page.dart';

class ReportOverview extends StatefulWidget {
  final Report report;
  const ReportOverview({super.key, required this.report});

  @override
  State<ReportOverview> createState() => _ReportOverviewState();
}

class _ReportOverviewState extends State<ReportOverview> {
  @override
  Widget build(BuildContext context) {
    List<BasicListItem> items = [];
    for (var item in widget.report.scannedItems) {
      items.add(BasicListItem(
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
        children: [
          Text(widget.report.toString()),
          Expanded(
            child: ListView(
              children: items,
            ),
          ),
          widget.report.isCompleted
              ? kSmallGap
              : SmallButton(
                  onTap: () {
                    context.read<ReportBloc>().add(ReportFinished());
                    Navigator.pop(context);
                  },
                  buttonTitle: 'zakończ inwentaryzacje'),
          kBigGap,
        ],
      ),
    );
  }
}
