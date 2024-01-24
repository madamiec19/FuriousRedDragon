part of 'add_item_bloc.dart';

/// Eventy możliwe do zajścia w [AddItemPage]

abstract class AddItemEvent {}

class AddItemInitial extends AddItemEvent {}

class AddItemBuildingChosen extends AddItemEvent {
  final int building;

  AddItemBuildingChosen({required this.building});
}

class AddItemRoomChosen extends AddItemEvent {
  final Room room;

  AddItemRoomChosen({required this.room});
}

class AddItemButtonClicked extends AddItemEvent {}

class AddItemFloorChosen extends AddItemEvent {
  final int floor;

  AddItemFloorChosen({required this.floor});
}
