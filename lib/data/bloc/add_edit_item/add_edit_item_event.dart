part of 'add_edit_item_bloc.dart';

abstract class AddEditItemEvent {}

class AddEditItemAddItemFromScanner extends AddEditItemEvent {
  final String code;

  AddEditItemAddItemFromScanner({
    required this.code,
  });
}

class AddEditItemAddFromRoom extends AddEditItemEvent {
  final Room room;

  AddEditItemAddFromRoom({
    required this.room,
  });
}

class AddEditItemEditFromItemPreview extends AddEditItemEvent {
  final Item item;

  AddEditItemEditFromItemPreview({
    required this.item,
  });
}

class AddEditItemEditFromReport extends AddEditItemEvent {
  final Item item;

  AddEditItemEditFromReport({
    required this.item,
  });
}

class AddEditItemCodeChanged extends AddEditItemEvent {
  final String code;

  AddEditItemCodeChanged({
    required this.code,
  });
}

class AddEditItemTypeChanged extends AddEditItemEvent {
  final String type;

  AddEditItemTypeChanged({
    required this.type,
  });
}

class AddEditItemBrandChanged extends AddEditItemEvent {
  final String brand;

  AddEditItemBrandChanged({
    required this.brand,
  });
}

class AddEditItemBuildingChanged extends AddEditItemEvent {
  final int idBuilding;

  AddEditItemBuildingChanged({
    required this.idBuilding,
  });
}

class AddEditItemFloorChanged extends AddEditItemEvent {
  final int floor;

  AddEditItemFloorChanged({
    required this.floor,
  });
}

class AddEditItemRoomChanged extends AddEditItemEvent {
  final int room;

  AddEditItemRoomChanged({
    required this.room,
  });
}

class AddEditItemStatusChanged extends AddEditItemEvent {
  final String status;

  AddEditItemStatusChanged({
    required this.status,
  });
}

class AddEditItemButtonClicked extends AddEditItemEvent {}

class AddEditItemFinish extends AddEditItemEvent {}
