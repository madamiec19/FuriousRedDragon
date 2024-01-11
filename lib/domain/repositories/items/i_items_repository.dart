import 'package:furious_red_dragon/data/models/item.dart';

abstract class IItemsRepository {
  Future<Item> getItemWithBarcode(String barcode);
}
