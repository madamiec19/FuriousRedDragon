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
  List<Object?> get props => [id, name, floor, buildingId, items];

  Room copyWith({
    int? id,
    int? name,
    int? floor,
    int? buildingId,
    List<Item>? items,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      floor: floor ?? this.floor,
      buildingId: buildingId ?? this.buildingId,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return '$name/$floor budynek $buildingId';
  }

  Room.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as int,
        floor = json['floor'] as int,
        buildingId = json['id_building'] as int,
        items = [];

  static const empty =
      Room(id: 0, name: 0, floor: -5, buildingId: 0, items: []);
}
