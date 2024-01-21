part of 'scanner_bloc.dart';

enum ScannerStatus {
  initialized,
  scanning,
  scanned,
  manualInput,
  itemFound,
  itemNotFound,
}

class ScannerState extends Equatable {
  final Item item;
  final ScannerStatus scannerStatus;
  final String scannedBarcode;

  const ScannerState({
    this.item = Item.empty,
    this.scannerStatus = ScannerStatus.initialized,
    this.scannedBarcode = '',
  });

  ScannerState copyWith(
          {Item? item, ScannerStatus? scannerStatus, String? scannedBarcode}) =>
      ScannerState(
        item: item ?? this.item,
        scannerStatus: scannerStatus ?? this.scannerStatus,
        scannedBarcode: scannedBarcode ?? this.scannedBarcode,
      );
  @override
  List<Object?> get props => [
        item,
        scannerStatus,
        scannedBarcode,
      ];

  bool isItemFound() => scannerStatus == ScannerStatus.itemFound;
  bool isScannerOffScreen() => scannerStatus != ScannerStatus.scanning;
  bool isItemNotFound() => scannerStatus == ScannerStatus.itemNotFound;
  bool isManualInput() => scannerStatus == ScannerStatus.manualInput;
}
