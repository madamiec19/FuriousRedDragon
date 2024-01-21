import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/items/i_items_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'scanner_state.dart';
part 'scanner_event.dart';

@Injectable()
class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final IItemsRepository _itemsRepository;

  ScannerBloc(this._itemsRepository) : super(const ScannerState()) {
    on<ScannerBarcodeScanned>(_onScannerBarcodeScanned);
    on<ScannerInitialized>(_onScannerInitialized);
    on<ScannerDetailsShown>(_onScannerDetailsShown);
    on<ScannerManualInputButtonClicked>(_onScannerManualInputButtonClicked);
    on<ScannerManualInputValue>(_onScannerManualInputValue);
  }

  void _onScannerManualInputValue(
      ScannerManualInputValue event, Emitter<ScannerState> emit) async {
    try {
      Item item = await _itemsRepository.getItemWithBarcode(event.code);

      emit(state.copyWith(
          item: item,
          scannerStatus: ScannerStatus.itemFound,
          scannedBarcode: event.code));
    } catch (error) {
      print(error.toString());
      emit(state.copyWith(
          scannerStatus: ScannerStatus.itemNotFound,
          scannedBarcode: event.code));
    }
  }

  void _onScannerManualInputButtonClicked(
      ScannerManualInputButtonClicked event, Emitter<ScannerState> emit) {
    emit(state.copyWith(scannerStatus: ScannerStatus.manualInput));
  }

  void _onScannerDetailsShown(
      ScannerDetailsShown event, Emitter<ScannerState> emit) {
    emit(state.copyWith(item: null, scannerStatus: ScannerStatus.initialized));
  }

  void _onScannerInitialized(
      ScannerInitialized event, Emitter<ScannerState> emit) {
    emit(state.copyWith(
        item: null, scannerStatus: ScannerStatus.scanning, scannedBarcode: ''));
  }

  Future<void> _onScannerBarcodeScanned(
      ScannerBarcodeScanned event, Emitter<ScannerState> emit) async {
    try {
      Item item =
          await _itemsRepository.getItemWithBarcode(event.barcode.code!);
      emit(state.copyWith(
          item: item,
          scannerStatus: ScannerStatus.itemFound,
          scannedBarcode: event.barcode.code));
    } catch (error) {
      print(error.toString());
      emit(state.copyWith(
          scannerStatus: ScannerStatus.itemNotFound,
          scannedBarcode: event.barcode.code));
    }
  }
}
