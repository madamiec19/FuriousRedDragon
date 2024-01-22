import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;
  final int idRoom;
  final String type;
  final String brand;
  final String barcode;
  final String state;

  const Item({
    required this.id,
    required this.idRoom,
    required this.type,
    required this.brand,
    required this.barcode,
    required this.state,
  });

  @override
  String toString() {
    return '$type $brand';
  }

  @override
  List<Object?> get props => [id, idRoom, type, brand, barcode, state];

  static const empty = Item(
    id: 0,
    idRoom: 0,
    type: '',
    brand: '',
    barcode: '',
    state: '',
  );

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        idRoom = json['id_room'] as int,
        type = json['type'] as String,
        brand = json['brand'] as String,
        barcode = json['serial_number'] as String,
        state = json['state'] as String;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_room': idRoom,
      'type': type,
      'brand': brand,
      'serial_number': barcode,
      'state': state,
    };
  }
}
