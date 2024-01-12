part of 'scanner_bloc.dart';

enum ScannerStatus {
  initialized,
  scanning,
  scanned,
  itemFound,
  itemNotFound,
}

class ScannerState extends Equatable {
  final Item item;
  final ScannerStatus scannerStatus;

  const ScannerState({
    this.item = Item.empty,
    this.scannerStatus = ScannerStatus.initialized,
  });

  ScannerState copyWith({Item? item, ScannerStatus? scannerStatus}) =>
      ScannerState(
        item: item ?? this.item,
        scannerStatus: scannerStatus ?? this.scannerStatus,
      );
  @override
  List<Object?> get props => [
        item,
        scannerStatus,
      ];

  bool isItemFound() => scannerStatus == ScannerStatus.itemFound;
  bool isScannerOffScreen() =>
      scannerStatus == ScannerStatus.itemFound ||
      scannerStatus == ScannerStatus.scanned ||
      scannerStatus == ScannerStatus.initialized;
}
