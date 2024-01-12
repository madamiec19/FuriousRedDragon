part of 'scanner_bloc.dart';

abstract class ScannerEvent {}

class ScannerBarcodeScanned extends ScannerEvent {
  final Barcode barcode;

  ScannerBarcodeScanned({required this.barcode});
}

class ScannerInitialized extends ScannerEvent {}

class ScannerDetailsShown extends ScannerEvent {}
