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
    return '$id $roomId $idAuthor $scannedItems';
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
        scannedItems = _parseScannedItems(json['scanned_items_id']),
        isCompleted = json['is_completed'] as bool;

  static List<Item> _parseScannedItems(dynamic jsonString) {
    if (jsonString is List) {
      List<dynamic> jsonList = json.decode(jsonString.toString());

      List<Item> result = [];

      for (List<dynamic> itemList in jsonList) {
        for (Map<String, dynamic> itemMap in itemList) {
          result.add(Item.fromJson(itemMap));
        }
      }
      return result;
    }
    return [];
  }

  static List<Item> parseJson(dynamic jsonString) {
    List<List<Map<String, dynamic>>> jsonList = json.decode(jsonString);

    List<Item> result = [];

    for (List<Map<String, dynamic>> itemList in jsonList) {
      for (Map<String, dynamic> itemMap in itemList) {
        result.add(Item.fromJson(itemMap));
      }
    }

    return result ?? [];
  }

  static const empty = Report(
      id: 0,
      createdAt: '',
      roomId: 0,
      idAuthor: 0,
      scannedItems: [],
      isCompleted: false);
}
