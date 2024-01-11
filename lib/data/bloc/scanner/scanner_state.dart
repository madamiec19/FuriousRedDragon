part of 'scanner_bloc.dart';

enum ScannerStatus {
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
    this.scannerStatus = ScannerStatus.scanning,
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
}
