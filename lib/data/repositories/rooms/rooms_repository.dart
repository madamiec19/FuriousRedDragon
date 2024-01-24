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
  Future<void> addRoom(int name, int floor, int idBuilding) async {
    try {
      await _supabaseClient
          .from('rooms')
          .insert({'name': name, 'floor': floor, 'id_building': idBuilding});
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<Room>> getAllRooms() async {
    try {
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
        for (var value in itemsResponse) {
          Item item = Item.fromJson(value);
          roomItems.add(item);
        }
        room = room.copyWith(items: roomItems);
        rooms.add(room);
      }
      return rooms;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  @override
  Future<Room> getRoomWithId(int id) async {
    try {
      final response =
          await _supabaseClient.from('rooms').select('*').eq('id', id).single();

      return Room.fromJson(response);
    } catch (error) {
      print(error.toString());
      return Room.empty;
    }
  }

  @override
  Future<List<Room>> getRoomsFromBuilding(int building) async {
    try {
      final response = await _supabaseClient
          .from('rooms')
          .select('*')
          .eq('id_building', building);
      List<Room> roomsInBuilding = [];
      for (var value in response) {
        Room room = Room.fromJson(value);
        roomsInBuilding.add(room);
      }
      return roomsInBuilding;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  @override
  Future<List<int>> getAllBuildings() async {
    try {
      final response =
          await _supabaseClient.from('rooms').select('id_building');
      List<int> buildings = [];
      for (var value in response) {
        int building = value['id_building'] as int;
        if (!buildings.contains(building)) {
          buildings.add(building);
        }
      }
      return buildings;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  @override
  Future<List<int>> getFloorsForBuilding(int building) async {
    try {
      final response = await _supabaseClient.from('rooms').select('floor').eq(
            'id_building',
            building,
          );
      print(response);
      List<int> floorsInBuilding = [];
      for (var value in response) {
        int floor = value['floor'] as int;
        if (!floorsInBuilding.contains(floor)) {
          floorsInBuilding.add(floor);
        }
      }
      print(floorsInBuilding);
      return floorsInBuilding;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  @override
  Future<List<Room>> getRoomsFromBuildingOnFloor(
      int building, int floor) async {
    try {
      final response = await _supabaseClient
          .from('rooms')
          .select('*')
          .eq(
            'id_building',
            building,
          )
          .eq('floor', floor);
      List<Room> roomsInBuilding = [];
      for (var value in response) {
        Room room = Room.fromJson(value);
        roomsInBuilding.add(room);
      }
      return roomsInBuilding;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}
