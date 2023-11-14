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
          kBigGap,
          BigWhiteButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondPage()),
              );
            },
            buttonTitle: ('Wpisz kod ręcznie'),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wprowadź kod kreskowy'),
      ),
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
            kBigGap,
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Wprowadź kod kreskowy',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                kBigGap,
                Image.network(
                  'https://edycja.pl/media/catalog/category/_jpII_www.png',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
            kBigGap,
            ElevatedButton(
              onPressed: () {
                // Dodaj obsługę po naciśnięciu przycisku "Zatwierdź"
                print('Zatwierdź');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Zatwierdź',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
