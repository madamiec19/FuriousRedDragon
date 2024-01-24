part of 'add_room_bloc.dart';

abstract class AddRoomEvent {}

class AddRoomInitial extends AddRoomEvent {}

class AddRoomBuildingEdited extends AddRoomEvent {
  final String building;

  AddRoomBuildingEdited({required this.building});
}

class AddRoomFloorEdited extends AddRoomEvent {
  final String floor;

  AddRoomFloorEdited({required this.floor});
}

class AddRoomRoomEdited extends AddRoomEvent {
  final String room;

  AddRoomRoomEdited({required this.room});
}

class AddRoomButtonClicked extends AddRoomEvent {}
