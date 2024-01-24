import 'package:furious_red_dragon/domain/repositories/entities/room.dart';

abstract class IRoomsRepository {
  Future<List<Room>> getAllRooms();

  Future<List<int>> getAllBuildings();

  Future<Room> getRoomWithId(int id);

  Future<void> addRoom(int name, int floor, int idBuilding);

  Future<List<Room>> getRoomsFromBuilding(int building);

  Future<List<int>> getFloorsForBuilding(int building);

  Future<List<Room>> getRoomsFromBuildingOnFloor(int building, int floor);
}
