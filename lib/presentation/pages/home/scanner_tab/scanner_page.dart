import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart';
import 'package:furious_red_dragon/presentation/components/item_details_page.dart';
import 'package:furious_red_dragon/presentation/components/white_card.dart';
import 'package:furious_red_dragon/presentation/pages/home/scanner_tab/barcode_reader.dart';

import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:flutter/services.dart';

part 'scanner_manual_input.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ScannerBloc>().add(ScannerInitialized());
    return BlocListener<ScannerBloc, ScannerState>(
      listenWhen: (previous, current) =>
          previous.scannerStatus != current.scannerStatus,
      listener: (BuildContext context, state) {
        ///gdy zeskanowany kod jest w bazie
        if (state.isItemFound()) {
          final reportState = BlocProvider.of<ReportBloc>(context).state;

          ///gdy raport jest zainicjowany dodaje zeskanowany przedmiot do raportu
          if (reportState.reportStatus == ReportStatus.initialized) {
            context.read<ReportBloc>().add(ReportItemAdded(item: state.item));
            const snackBar = SnackBar(
              content: Text('Przedmiot dodany do raportu!'),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            context.read<ScannerBloc>().add(ScannerInitialized());
          }

          ///gdy raport nie jest zainicjowany, ale przedmiot jest w bazie pokaż jego szczegóły
          else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemDetailsPage(item: state.item)),
            );
          }
        }

        ///gdy zeskanowany kod którego nie ma w bazie TODO dodać możliwość dodania nowego przedmiotu, rozważyć co kiedy raport jest zainicjalizowany a zeskowanego kodu nie ma w bazie
        else if (state.isItemNotFound()) {
          const snackBar = SnackBar(
            content: Text('Brak przedmiotu w bazie'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<ScannerBloc>().add(ScannerInitialized());
        }

        ///gdy klikniemy w przycisk ręcznego dodania
        else if (state.isManualInput()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ScannerManualInput()));
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: BarcodeReader(),
              ),
              kBigGap,
              BigWhiteButton(
                onTap: () {
                  context
                      .read<ScannerBloc>()
                      .add(ScannerManualInputButtonClicked());
                },
                buttonTitle: ('Wpisz kod ręcznie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
