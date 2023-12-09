import 'package:flutter/material.dart';
import 'package:furious_red_dragon/components/scan_barcode.dart';

import '../../constants.dart';
import 'package:furious_red_dragon/components/buttons.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScannerPage();
  }
}

class MainScannerPage extends StatelessWidget {
  const MainScannerPage({super.key});

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
                      builder: (context) => const SecondScannerPage()),
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

class SecondScannerPage extends StatelessWidget {
  const SecondScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        )),
        backgroundColor: kFuriousRedColor,
        title: const Text('Skanowanie'),
        actions: const <Widget>[],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Wprowadź kod kreskowy:',
              style: kGlobalTextStyle.copyWith(fontSize: 22),
            ),
            kBigGap,
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Wprowadź cyfry',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                kBigGap,
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.info, size: 32)),
              ],
            ),
            kBigGap,
            SmallButton(
              onTap: () {},
              buttonTitle: ('Zatwierdź'),
              backgroundColor: kDarkerGrey,
            )
          ],
        ),
      ),
    );
  }
}
