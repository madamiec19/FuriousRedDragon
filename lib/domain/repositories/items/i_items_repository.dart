import 'package:furious_red_dragon/domain/repositories/entities/item.dart';

abstract class IItemsRepository {
  Future<Item> getItemWithBarcode(String barcode);
}
