import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/add_edit_item/add_edit_item_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart';
import 'package:furious_red_dragon/presentation/components/item_details_page.dart';
import 'package:furious_red_dragon/presentation/pages/add_item.dart';
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

        ///gdy zeskanowany kod którego nie ma w bazie
        else if (state.isItemNotFound()) {
          Widget cancelButton = TextButton(
            child: Text("Nie"),
            onPressed: () {
              Navigator.pop(context);
              context.read<ScannerBloc>().add(ScannerInitialized());
            },
          );
          Widget continueButton = TextButton(
            child: Text("Tak"),
            onPressed: () {
              context.read<AddEditItemBloc>().add(
                  AddEditItemAddItemFromScanner(code: state.scannedBarcode));
              Navigator.pop(context);
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddItemPage()))
                  .then((value) =>
                      context.read<ScannerBloc>().add(ScannerInitialized()));
            },
          );
          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            content: Text(
                "Nie znaleziono przedmiotu w bazie o kodzie ${state.scannedBarcode}, chcesz go dodać?"),
            actions: [
              cancelButton,
              continueButton,
            ],
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
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
