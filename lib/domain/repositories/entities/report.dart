import 'package:equatable/equatable.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';

class Report extends Equatable {
  final int id;
  final int idAuthor;
  final String createdAt;
  final int roomId;
  final List<Item> scannedItems;
  final bool isCompleted;

  const Report({
    required this.id,
    required this.createdAt,
    required this.roomId,
    required this.idAuthor,
    required this.scannedItems,
    required this.isCompleted,
  });

  @override
  String toString() {
    return '$roomId $idAuthor';
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        idAuthor,
        roomId,
        scannedItems,
        isCompleted,
      ];

  static const empty = Report(
      id: 0,
      createdAt: '',
      roomId: 0,
      idAuthor: 0,
      scannedItems: [],
      isCompleted: false);
}
