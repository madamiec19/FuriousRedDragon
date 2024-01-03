import 'package:furious_red_dragon/data/models/item.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/items/i_items_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IAuthenticationRepository)
class ItemsRepository implements IItemsRepository {
  final SupabaseClient _supabaseClient;

  ItemsRepository(this._supabaseClient);

  @override
  Item? getItemWithBarcode(int id) {
    _supabaseClient.from('items').stream(primaryKey: ['id']).eq('id', id);
  }
}
