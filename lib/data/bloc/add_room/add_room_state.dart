part of 'add_room_bloc.dart';

enum AddRoomStatus {
  adding,
  added,
}

class AddRoomState extends Equatable {
  final String building;
  final String floor;
  final String room;
  final AddRoomStatus addRoomStatus;

  const AddRoomState({
    this.building = '',
    this.floor = '',
    this.room = '',
    this.addRoomStatus = AddRoomStatus.adding,
  });

  AddRoomState copyWith(
          {String? building,
          String? floor,
          String? room,
          AddRoomStatus? addRoomStatus}) =>
      AddRoomState(
          building: building ?? this.building,
          room: room ?? this.room,
          floor: floor ?? this.floor,
          addRoomStatus: addRoomStatus ?? this.addRoomStatus);

  @override
  List<Object?> get props => [
        building,
        floor,
        room,
        addRoomStatus,
      ];

  bool isAdded() => addRoomStatus == AddRoomStatus.added;
  bool isAllFilled() =>
      building.isNotEmpty && floor.isNotEmpty && room.isNotEmpty;
}
