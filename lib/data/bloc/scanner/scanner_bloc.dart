import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/models/item.dart';
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
  }

  Future<void> _onScannerBarcodeScanned(
      ScannerBarcodeScanned event, Emitter<ScannerState> emit) async {
    try {
      Item item =
          await _itemsRepository.getItemWithBarcode(event.barcode.code!);
      emit(state.copyWith(item: item, scannerStatus: ScannerStatus.itemFound));
      print('sdasdsad');
    } catch (error) {
      print(error.toString());
    }
  }
}
