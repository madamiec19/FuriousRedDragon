part of 'add_report_bloc.dart';

enum AddReportStatus {
  adding,
  added,
}

/// Klasa opisująca stan [AddReportPage]
class AddReportState extends Equatable {
  final List<int> buildings;
  final List<Room> rooms;
  final Room chosenRoom;
  final int chosenBuilding;
  final AddReportStatus addReportStatus;

  const AddReportState({
    this.buildings = const [],
    this.rooms = const [],
    this.chosenRoom = Room.empty,
    this.chosenBuilding = -1,
    this.addReportStatus = AddReportStatus.adding,
  });

  AddReportState copyWith({
    List<int>? buildings,
    List<Room>? rooms,
    Room? chosenRoom,
    int? chosenBuilding,
    AddReportStatus? addReportStatus,
  }) =>
      AddReportState(
        buildings: buildings ?? this.buildings,
        rooms: rooms ?? this.rooms,
        chosenBuilding: chosenBuilding ?? this.chosenBuilding,
        chosenRoom: chosenRoom ?? this.chosenRoom,
        addReportStatus: addReportStatus ?? this.addReportStatus,
      );

  @override
  List<Object?> get props => [
        buildings,
        rooms,
        chosenRoom,
        chosenBuilding,
        addReportStatus,
      ];

  bool isAdded() => addReportStatus == AddReportStatus.added;
  bool isBuildingChosen() => chosenBuilding != -1;
  bool isRoomChosen() => chosenRoom != Room.empty;
}
