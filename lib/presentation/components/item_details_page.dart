import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart';
import 'package:furious_red_dragon/data/models/item.dart';
import 'package:furious_red_dragon/presentation/components/white_card.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ScannerBloc>().add(ScannerInitialized());
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ScannerBloc, ScannerState>(
          builder: (context, state) {
            Item item = state.item;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/monitor.png',
                  width: kScreenWidth * 0.35,
                ),
                Expanded(
                    child: WhiteCard(
                        child: Column(
                  children: [
                    Text('Informacje o przedmiocie'),
                    Row(
                      children: [
                        const Text(
                          'Kod: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(item.barcode),
                      ],
                    ),
                    kSmallGap,
                    Row(
                      children: [
                        const Text(
                          'Typ: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(item.type),
                      ],
                    ),
                    kSmallGap,
                    Row(
                      children: [
                        const Text(
                          'Producent: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(item.brand),
                      ],
                    ),
                    kSmallGap,
                    const Row(
                      children: [
                        Text(
                          'Budynek: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('[do zrobienia po stworzeniu room repo]'),
                      ],
                    ),
                    kSmallGap,
                    const Row(
                      children: [
                        Text(
                          'Sala: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('[do zrobienia po stworzeniu room repo]'),
                      ],
                    ),
                    kSmallGap,
                    const Row(
                      children: [
                        Text(
                          'Data dodania: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('[nie ma takiego parametru w bazie]'),
                      ],
                    ),
                    kSmallGap,
                    Row(
                      children: [
                        const Text(
                          'Status: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(item.state),
                      ],
                    )
                  ],
                )))
              ],
            );
          },
        ),
      ),
    );
  }
}
