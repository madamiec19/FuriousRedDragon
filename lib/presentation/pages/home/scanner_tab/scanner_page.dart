import 'package:flutter/material.dart';
import 'package:furious_red_dragon/presentation/pages/home/scanner_tab/scan_barcode.dart';

import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';
import 'package:flutter/services.dart';

part 'scanner_manual_input.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
