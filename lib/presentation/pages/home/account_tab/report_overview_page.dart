import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class ReportOverview extends StatelessWidget {
  const ReportOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(builder: (context, state) {
      Report report = state.report;
      List<BasicListItem> items = [];
      for (var item in report.scannedItems) {
        items.add(BasicListItem(onTap: () {}, buttonTitle: item.toString()));
      }
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text(state.report.createdAt),
            Expanded(
              child: ListView(
                children: items,
              ),
            ),
          ],
        ),
      );
    });
  }
}
