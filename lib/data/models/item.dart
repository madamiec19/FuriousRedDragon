class Item {
  String type;
  String brand;
  String serialNumber;
  String barcode;

  Item(
      {required this.type,
      required this.brand,
      required this.serialNumber,
      required this.barcode});

  @override
  String toString() {
    return '$type $brand';
  }
}
