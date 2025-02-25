part of 'add_report_bloc.dart';

enum AddReportStatus {
  adding,
  added,
}

/// Klasa opisująca stan [AddReportPage]
class AddReportState extends Equatable {
  final List<int> buildings;
  final List<int> floors;
  final List<Room> rooms;
  final Room chosenRoom;
  final int chosenFloor;
  final int chosenBuilding;
  final AddReportStatus addReportStatus;

  const AddReportState({
    this.buildings = const [],
    this.rooms = const [],
    this.floors = const [],
    this.chosenRoom = Room.empty,
    this.chosenFloor = -3,
    this.chosenBuilding = -1,
    this.addReportStatus = AddReportStatus.adding,
  });

  AddReportState copyWith({
    List<int>? buildings,
    List<Room>? rooms,
    List<int>? floors,
    Room? chosenRoom,
    int? chosenFloor,
    int? chosenBuilding,
    AddReportStatus? addReportStatus,
  }) =>
      AddReportState(
        buildings: buildings ?? this.buildings,
        rooms: rooms ?? this.rooms,
        floors: floors ?? this.floors,
        chosenBuilding: chosenBuilding ?? this.chosenBuilding,
        chosenFloor: chosenFloor ?? this.chosenFloor,
        chosenRoom: chosenRoom ?? this.chosenRoom,
        addReportStatus: addReportStatus ?? this.addReportStatus,
      );

  @override
  List<Object?> get props => [
        buildings,
        rooms,
        floors,
        chosenRoom,
        chosenFloor,
        chosenBuilding,
        addReportStatus,
      ];

  bool isAdded() => addReportStatus == AddReportStatus.added;
  bool isBuildingChosen() => chosenBuilding != -1;
  bool isFloorChosen() => chosenFloor != -3;
  bool isRoomChosen() => chosenRoom != Room.empty;
}
