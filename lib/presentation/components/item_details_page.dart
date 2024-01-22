import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/presentation/components/white_card.dart';

class ItemDetailsPage extends StatefulWidget {
  final Item item;
  const ItemDetailsPage({super.key, required this.item});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
              const Text('Informacje o przedmiocie'),
              Row(
                children: [
                  const Text(
                    'Kod: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.item.barcode),
                ],
              ),
              kSmallGap,
              Row(
                children: [
                  const Text(
                    'Typ: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.item.type),
                ],
              ),
              kSmallGap,
              Row(
                children: [
                  const Text(
                    'Producent: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.item.brand),
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
                  Text(widget.item.state),
                ],
              )
            ],
          )))
        ],
      ),
    );
  }
}
