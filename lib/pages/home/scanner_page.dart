import 'package:flutter/material.dart';

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
            const Text(
              'Wprowadź kod kreskowy:',
              style: TextStyle(fontFamily: 'Lato', fontSize: 22),
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
                    onPressed: () {}, icon: const Icon(Icons.info, size: 32))
                /*
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Minimalist_info_Icon.png/800px-Minimalist_info_Icon.png',
                  height: 30,
                  width: 30,
                )*/
                ,
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
