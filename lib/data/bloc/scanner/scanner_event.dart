part of 'scanner_bloc.dart';

abstract class ScannerEvent {}

class ScannerBarcodeScanned extends ScannerEvent {
  final Barcode value;

  ScannerBarcodeScanned({required this.value});
}
