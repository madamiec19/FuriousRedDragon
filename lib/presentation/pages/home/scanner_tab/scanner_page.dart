import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart';
import 'package:furious_red_dragon/presentation/components/item_details_page.dart';
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
        if (state.isItemFound()) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ItemDetailsPage()),
          );
        } else if (state.isItemNotFound()) {
          const snackBar = SnackBar(
            content: Text('Brak przedmiotu w bazie'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<ScannerBloc>().add(ScannerInitialized());
        } else if (state.isManualInput()) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScannerManualInput()));
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
