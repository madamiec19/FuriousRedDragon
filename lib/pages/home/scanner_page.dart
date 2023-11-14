import 'package:flutter/material.dart';

import '../../constants.dart';
import 'package:furious_red_dragon/components/buttons.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kPageBackgroundColor,
        body: MainScannerPage(),
      ),
    );
  }
}

class MainScannerPage extends StatelessWidget {
  const MainScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            color: kDarkerGrey,
          ),
          const SizedBox(height: 20),
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
    );
  }
}

class SecondScannerPage extends StatelessWidget {
  const SecondScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Skanuj'),
        backgroundColor: kFuriousRedColor,
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Wprowadź kod kreskowy:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
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
                const SizedBox(width: 20),
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Minimalist_info_Icon.png/800px-Minimalist_info_Icon.png',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
            const SizedBox(height: 20),
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
