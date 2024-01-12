import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart';
import 'package:furious_red_dragon/presentation/components/item_details_page.dart';
import 'package:furious_red_dragon/presentation/pages/home/scanner_tab/scan_barcode.dart';

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
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BarcodeReader(),
              ),
              kBigGap,
              BigWhiteButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScannerManualInput()),
                  );
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
