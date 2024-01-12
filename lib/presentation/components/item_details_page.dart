import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart';
import 'package:furious_red_dragon/data/models/item.dart';

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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item.id.toString()),
                  Text(item.idRoom.toString()),
                  Text(item.type),
                  Text(item.brand),
                  Text(item.barcode),
                  Text(item.state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
