import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';

class Report extends Equatable {
  final int id;
  final int idAuthor;
  final String createdAt;
  final int roomId;
  final List<Item> scannedItems;
  final bool isCompleted;

  final String author;
  final String room;

  const Report({
    required this.id,
    required this.createdAt,
    required this.roomId,
    required this.idAuthor,
    required this.scannedItems,
    required this.isCompleted,
    required this.author,
    required this.room,
  });

  @override
  String toString() {
    DateTime createdAtDT = DateTime.parse(createdAt);
    return '$room z dnia ${createdAtDT.day}/${createdAtDT.month}/${createdAtDT.year}';
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        idAuthor,
        roomId,
        scannedItems,
        isCompleted,
        author,
        room,
      ];

  Report copyWith({
    int? id,
    int? idAuthor,
    String? createdAt,
    int? roomId,
    List<Item>? scannedItems,
    bool? isCompleted,
    String? author,
    String? room,
  }) {
    return Report(
      id: id ?? this.id,
      idAuthor: idAuthor ?? this.idAuthor,
      createdAt: createdAt ?? this.createdAt,
      roomId: roomId ?? this.roomId,
      scannedItems: scannedItems ?? this.scannedItems,
      isCompleted: isCompleted ?? this.isCompleted,
      author: author ?? this.author,
      room: room ?? this.room,
    );
  }

  Report.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        idAuthor = json['author_id'] as int,
        roomId = json['room_id'] as int,
        createdAt = json['created_at'] as String,
        scannedItems = _parseScannedItems(json['scanned_items_id']),
        isCompleted = json['is_completed'] as bool,
        author = '',
        room = '';

  static List<Item> _parseScannedItems(dynamic jsonString) {
    if (jsonString is List) {
      List<dynamic> jsonList = json.decode(jsonString.toString());

      List<Item> result = [];

      for (List<dynamic> itemList in jsonList) {
        for (Map<String, dynamic> itemMap in itemList) {
          print(itemMap);
          result.add(Item.fromJson(itemMap));
        }
      }
      return result;
    }
    return [];
  }

  static const empty = Report(
      id: 0,
      createdAt: '',
      roomId: 0,
      idAuthor: 0,
      scannedItems: [],
      isCompleted: false,
      author: '',
      room: '');
}
