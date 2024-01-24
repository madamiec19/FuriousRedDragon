part of 'add_item_bloc.dart';

enum AddItemStatusEnum {
  adding,
  added,
}

/// Klasa opisująca stan [AddItemPage]
class AddItemStatus extends Equatable {
  final List<int> buildings;
  final List<int> floors;
  final List<Room> rooms;
  final Room chosenRoom;
  final int chosenFloor;
  final int chosenBuilding;
  final AddItemStatusEnum addItemStatus;

  const AddItemState({
    this.buildings = const [],
    this.rooms = const [],
    this.floors = const [],
    this.chosenRoom = Room.empty,
    this.chosenFloor = -3,
    this.chosenBuilding = -1,
    this.addItemStatus = AddItemStateEnum.adding,
  });

  AddItemState copyWith({
    List<int>? buildings,
    List<Room>? rooms,
    List<int>? floors,
    Room? chosenRoom,
    int? chosenFloor,
    int? chosenBuilding,
    AddItemStatus? addReportStatus,
  }) =>
      AddItemState(
        buildings: buildings ?? this.buildings,
        rooms: rooms ?? this.rooms,
        floors: floors ?? this.floors,
        chosenBuilding: chosenBuilding ?? this.chosenBuilding,
        chosenFloor: chosenFloor ?? this.chosenFloor,
        chosenRoom: chosenRoom ?? this.chosenRoom,
        addItemStatus: addReportStatus ?? this.addItemStatus,
      );

  @override
  List<Object?> get props => [
        buildings,
        rooms,
        floors,
        chosenRoom,
        chosenFloor,
        chosenBuilding,
        addItemStatus,
      ];

  bool isAdded() => addItemStatus == AddItemStatusEnum.added;
  bool isBuildingChosen() => chosenBuilding != -1;
  bool isFloorChosen() => chosenFloor != -3;
  bool isRoomChosen() => chosenRoom != Room.empty;
}
