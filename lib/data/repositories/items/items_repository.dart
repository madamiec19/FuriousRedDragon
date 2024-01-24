import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/items/i_items_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IItemsRepository)
class ItemsRepository implements IItemsRepository {
  final SupabaseClient _supabaseClient;

  ItemsRepository(this._supabaseClient);

  @override
  Future<Item> getItemWithBarcode(String barcode) async {
    final response = await _supabaseClient
        .from('items')
        .select('*')
        .eq('serial_number', barcode)
        .single();
    return Item(
        id: response['id'],
        idRoom: response['id_room'],
        type: response['type'],
        brand: response['brand'],
        barcode: response['serial_number'],
        state: response['state']);
  }

  @override
  Future<Item> addItem(
      String code, String type, String brand, int room, String status) async {
    print('elo');
    final response = await _supabaseClient.from('items').insert([
      {
        'id_room': room,
        'type': type,
        'brand': brand,
        'serial_number': code,
        'state': status,
      }
    ]).select();

    Item item = Item.fromJson(response[0]);
    return item;
  }
}
