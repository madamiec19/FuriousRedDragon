import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IRoomsRepository)
class RoomRepository implements IRoomsRepository {
  final SupabaseClient _supabaseClient;

  RoomRepository(this._supabaseClient);

  @override
  Future<void> addRoom(String name, int floor, int idBuilding) async {
    try {
      final response = await _supabaseClient
          .from('rooms')
          .insert({'name': name, 'floor': floor, 'id_building': idBuilding});
      print(response.toString());
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<Room>> getAllRooms() async {
    final response =
        await _supabaseClient.from('rooms').select('*').order('name');
    List<Room> rooms = [];

    for (var value in response) {
      Room room = Room.fromJson(value);
      List<Item> roomItems = [];
      final itemsResponse = await _supabaseClient
          .from('items')
          .select('*')
          .eq('id_room', room.id);
      print(itemsResponse);
      for (var value in itemsResponse) {
        Item item = Item.fromJson(value);
        roomItems.add(item);
      }
      room = room.copyWith(items: roomItems);
      rooms.add(room);
    }
    return rooms;
  }

  @override
  Future<Room> getRoomWithId(int id) async {
    try {
      final response =
          await _supabaseClient.from('rooms').select('*').eq('id', id);

      return response;
    } catch (error) {
      print(error.toString());
    }
    return Room.empty;
  }
}
