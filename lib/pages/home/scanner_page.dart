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

class SecondScannerPage extends StatefulWidget {
  const SecondScannerPage({super.key});

  @override
  _SecondScannerPage createState() => _SecondScannerPage();
}

class _SecondScannerPage extends State<SecondScannerPage> {
  bool showInfoPopUp = false;

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
                    onPressed: () {
                      setState(() {
                        showInfoPopUp = !showInfoPopUp;
                      });
                    }, 
                    icon: const Icon(Icons.info, size: 32))
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
            ),
            kBigGap,
            if (showInfoPopUp) const InfoPopUp()
          ],
        ),
      ),
    );
  }
}

class InfoPopUp extends StatelessWidget {
  const InfoPopUp({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kFuriousRedColor,
          width: 2,
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Dlaczego nie mogę zatwierdzić kodu?',
            style: kGlobalTextStyle.copyWith(fontSize: 17),
          ),
          kBigGap,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(8),
            child:
              Text(
                'Przed zatwierdzeniem kodu upewnij się, że:\n'
                '  • kod składa się tylko z cyfr (bez spacji)\n'
                '  • kod składa się dokładnie z 13 cyfr\n',
                style: kGlobalTextStyle.copyWith(fontSize: 14, height: 1.5),
              ),
          ),
        ],
    )
    );
  }
}