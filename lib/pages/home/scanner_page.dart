import 'package:flutter/material.dart';

import '../../constants.dart';
import 'package:furious_red_dragon/components/buttons.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: kPageBackgroundColor,
        body: MainScannerPage(),
=======
    return MaterialApp(
      home: Scaffold(
        backgroundColor: pageBackgroundColor,
        body: MyWidget(),
>>>>>>> Stashed changes
      ),
    );
  }
}

<<<<<<< Updated upstream
class MainScannerPage extends StatelessWidget {
  const MainScannerPage({super.key});

=======
class MyWidget extends StatelessWidget {
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
<<<<<<< Updated upstream
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
=======
          // Obraz
          Image.network(
            'https://kropa.pl/data/gfx/pictures/large/7/4/110147_1.jpg', // Zastąp adresem URL obrazu
            height: 200.0, // Dostosuj wysokość obrazu
            width: 200.0, // Dostosuj szerokość obrazu
          ),

          SizedBox(
              height: 20), // Pusty odstęp między obrazem a obrazem przycisku

          // ElevatedButton jako przycisk
          ElevatedButton(
            onPressed: () {
              // Przejście do nowej strony po naciśnięciu przycisku
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Wprowadź kod ręcznie',
                style: TextStyle(fontSize: 18),
              ),
            ),
>>>>>>> Stashed changes
          ),
        ],
      ),
    );
  }
}

<<<<<<< Updated upstream
class SecondScannerPage extends StatelessWidget {
  const SecondScannerPage({super.key});

=======
class SecondPage extends StatelessWidget {
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< Updated upstream
        title: const Text('Skanuj'),
        backgroundColor: kFuriousRedColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
=======
        title: Text('Wprowadź kod kreskowy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
>>>>>>> Stashed changes
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
<<<<<<< Updated upstream
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
=======
            Text(
              'Wprowadź kod kreskowy:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Wprowadź kod',
>>>>>>> Stashed changes
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
<<<<<<< Updated upstream
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
=======
                SizedBox(width: 20),
                Image.network(
                  'https://edycja.pl/media/catalog/category/_jpII_www.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Dodaj obsługę po naciśnięciu przycisku "Zatwierdź"
                print('Zatwierdź');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Zatwierdź',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
>>>>>>> Stashed changes
          ],
        ),
      ),
    );
  }
}
