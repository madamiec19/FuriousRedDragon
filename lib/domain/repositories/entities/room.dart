import 'package:furious_red_dragon/domain/repositories/entities/item.dart';

class Room {
  int id;
  int name;
  int floor;
  int buildingId;
  Item items;

  Room(
      {required this.id,
      required this.name,
      required this.floor,
      required this.buildingId,
      required this.items});
}
