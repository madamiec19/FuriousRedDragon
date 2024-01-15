import 'package:furious_red_dragon/domain/repositories/entities/item.dart';

class Report {
  int id;
  String createdAt;
  String author;
  String roomId;
  List<Item> scannedItems;
  bool isCompleted;

  Report({
    required this.id,
    required this.createdAt,
    required this.roomId,
    required this.author,
    required this.scannedItems,
    required this.isCompleted,
  });

  void markAsCompleted() => isCompleted = true;

  @override
  String toString() {
    return '$roomId $author';
  }
}
