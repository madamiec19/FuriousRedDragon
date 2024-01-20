import 'package:equatable/equatable.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';

class Room extends Equatable {
  final int id;
  final int name;
  final int floor;
  final int buildingId;
  final List<Item> items;

  const Room(
      {required this.id,
      required this.name,
      required this.floor,
      required this.buildingId,
      required this.items});

  @override
  List<Object?> get props => throw [id, name, floor, buildingId, items];

  static const empty =
      Room(id: 0, name: 0, floor: -5, buildingId: 0, items: []);
}
