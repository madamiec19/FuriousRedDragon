import 'package:furious_red_dragon/domain/repositories/entities/item.dart';

abstract class IItemsRepository {
  Future<Item> getItemWithBarcode(String barcode);

  Future<Item> addItem(
    String code,
    String type,
    String brand,
    int room,
    String status,
  );
}
