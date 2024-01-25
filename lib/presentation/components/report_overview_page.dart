import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report_overview/report_overview_bloc.dart';
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
    context
        .read<ReportOverviewBloc>()
        .add(ReportOverviewInit(report: widget.report));
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
    return WillPopScope(
      onWillPop: () async {
        context.read<ReportOverviewBloc>().add(ReportOverviewClose());
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text(widget.report.toString()),
            kBigGap,
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Zeskanowane przedmioty'),
                        Expanded(
                          child: ListView(
                            children: items,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<ReportOverviewBloc, ReportOverviewState>(
                        builder: (context, state) {
                      List<BasicListItem> items = [];
                      for (var item in state.itemsFromReportedRoom) {
                        items.add(BasicListItem(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ItemDetailsPage(item: item)));
                            },
                            buttonTitle: item.toString()));
                      }
                      return Column(
                        children: [
                          const Text('Przedmioty z sali'),
                          Expanded(
                            child: ListView(
                              children: items.isEmpty
                                  ? [
                                      const Text('pomieszczenie jest puste'),
                                    ]
                                  : items,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            context.select((ReportBloc b) => b.state.report.id) ==
                    widget.report.id
                ? SmallButton(
                    onTap: () {
                      context.read<ReportBloc>().add(ReportFinished());
                      Navigator.pop(context);
                    },
                    buttonTitle: 'zakończ inwentaryzacje')
                : kSmallGap,
            kBigGap,
          ],
        ),
      ),
    );
  }
}
