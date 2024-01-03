import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'scanner_state.dart';
part 'scanner_event.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  //todo repozytorium przedmiotów
  //final IItemsRepository _itemsRepository;

  ScannerBloc() : super(ScannerState()) {
    on<ScannerBarcodeScanned>(_onScannerBarcodeScanned);
  }

  Future<void> _onScannerBarcodeScanned(
      ScannerBarcodeScanned event, Emitter<ScannerState> emit) async {}
}
