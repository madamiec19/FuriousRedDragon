import 'package:furious_red_dragon/domain/repositories/entities/room.dart';

abstract class IRoomsRepository {
  Future<List<Room>> getAllRooms();

  Future<Room> getRoomWithId(int id);

  Future<void> addRoom(String name, int floor, int idBuilding);
}
