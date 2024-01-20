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
  Future<List<Room>> getAllRooms() {
    // TODO: implement getAllRooms
    throw UnimplementedError();
  }
}
