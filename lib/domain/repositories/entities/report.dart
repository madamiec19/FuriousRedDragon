import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final int id;
  final int idAuthor;
  final String createdAt;
  final int roomId;
  final scannedItems;
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

  Report.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        idAuthor = json['author_id'] as int,
        roomId = json['room_id'] as int,
        createdAt = json['created_at'] as String,
        scannedItems = json['scatted_items_id'],
        isCompleted = json['is_completed'] as bool;

  static const empty = Report(
      id: 0,
      createdAt: '',
      roomId: 0,
      idAuthor: 0,
      scannedItems: [],
      isCompleted: false);
}
