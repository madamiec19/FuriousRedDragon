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
}
