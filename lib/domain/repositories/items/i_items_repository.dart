import 'package:furious_red_dragon/data/models/item.dart';

abstract class IItemsRepository {
  Item? getItemWithBarcode(int barcode);
}
