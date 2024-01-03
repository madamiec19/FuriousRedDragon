class Item {
  int id;
  int idRoom;
  String type;
  String brand;
  String barcode;
  String state;

  Item({
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
}
