part of 'add_edit_item_bloc.dart';

enum AddEditItemStatus {
  initial,
  editing,
  addingInRoom,
  addingInScanner,
  addingInScannerDuringReport,
  added,
}

class AddEditItemState extends Equatable {
  final AddEditItemStatus addEditItemStatus;
  final String code;
  final String type;
  final String brand;
  final int idBuilding;
  final int floor;
  final int room;
  final String status;
  final Room roomOfItem;
  final List<int> buildings;
  final List<int> floors;
  final List<Room> rooms;

  const AddEditItemState({
    this.addEditItemStatus = AddEditItemStatus.initial,
    this.code = '',
    this.type = '',
    this.brand = '',
    this.idBuilding = -1,
    this.floor = -3,
    this.room = -3,
    this.status = '',
    this.roomOfItem = Room.empty,
    this.buildings = const [],
    this.floors = const [],
    this.rooms = const [],
  });

  AddEditItemState copyWith({
    AddEditItemStatus? addEditItemStatus,
    String? code,
    String? type,
    String? brand,
    int? idBuilding,
    int? floor,
    int? room,
    String? status,
    Room? roomOfItem,
    List<int>? floors,
    List<int>? buildings,
    List<Room>? rooms,
  }) =>
      AddEditItemState(
        addEditItemStatus: addEditItemStatus ?? this.addEditItemStatus,
        code: code ?? this.code,
        type: type ?? this.type,
        brand: brand ?? this.brand,
        idBuilding: idBuilding ?? this.idBuilding,
        floor: floor ?? this.floor,
        room: room ?? this.room,
        status: status ?? this.status,
        roomOfItem: roomOfItem ?? this.roomOfItem,
        floors: floors ?? this.floors,
        buildings: buildings ?? this.buildings,
        rooms: rooms ?? this.rooms,
      );

  @override
  List<Object?> get props => [
        addEditItemStatus,
        type,
        brand,
        idBuilding,
        floor,
        room,
        status,
        roomOfItem,
        floors,
        buildings,
        rooms,
      ];

  bool isBuildingChosen() => idBuilding != -1;
  bool isFloorChosen() => floor != -3;
  bool isRoomProvided() =>
      addEditItemStatus == AddEditItemStatus.editing ||
      addEditItemStatus == AddEditItemStatus.addingInRoom ||
      addEditItemStatus == AddEditItemStatus.addingInScannerDuringReport;
  bool isAllInputed() =>
      type.isNotEmpty &&
      brand.isNotEmpty &&
      idBuilding != -1 &&
      floor != -3 &&
      room != -3 &&
      status.isNotEmpty;
  bool isFinished() => addEditItemStatus == AddEditItemStatus.added;
}
