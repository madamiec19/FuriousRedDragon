import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/domain/repositories/items/i_items_repository.dart';
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart';
import 'package:injectable/injectable.dart';

part 'add_edit_item_state.dart';
part 'add_edit_item_event.dart';

@Injectable()
class AddEditItemBloc extends Bloc<AddEditItemEvent, AddEditItemState> {
  final IItemsRepository _itemsRepository;
  final IRoomsRepository _roomsRepository;

  AddEditItemBloc(this._itemsRepository, this._roomsRepository)
      : super(const AddEditItemState()) {
    on<AddEditItemAddItemFromScanner>(_onAddingFromScanner);
    on<AddEditItemAddFromRoom>(_onAddingFromRoom);
    on<AddEditItemEditFromItemPreview>(_onEditingFromItemPreview);
    on<AddEditItemEditFromReport>(_onEditingFromReport);
    on<AddEditItemCodeChanged>(_onCodeChanged);
    on<AddEditItemTypeChanged>(_onTypeChanged);
    on<AddEditItemBrandChanged>(_onBrandChanged);
    on<AddEditItemBuildingChanged>(_onBuildingChanged);
    on<AddEditItemFloorChanged>(_onFloorChanged);
    on<AddEditItemRoomChanged>(_onRoomChanged);
    on<AddEditItemStatusChanged>(_onStatusChanged);
    on<AddEditItemButtonClicked>(_onButtonClicked);
    on<AddEditItemFinish>(_onFinish);
  }

  Future<void> _onAddingFromScanner(AddEditItemAddItemFromScanner event,
      Emitter<AddEditItemState> emit) async {
    emit(state.copyWith(
        code: event.code,
        addEditItemStatus: AddEditItemStatus.addingInScanner));
    List<int> buildings = await _roomsRepository.getAllBuildings();
    emit(state.copyWith(buildings: buildings));
  }

  Future<void> _onAddingFromRoom(
      AddEditItemAddFromRoom event, Emitter<AddEditItemState> emit) async {
    emit(state.copyWith(
      addEditItemStatus: AddEditItemStatus.addingInRoom,
      idBuilding: event.room.buildingId,
      floor: event.room.floor,
      room: event.room.name,
      roomOfItem: event.room,
    ));
    List<int> buildings = await _roomsRepository.getAllBuildings();
    List<int> floors =
        await _roomsRepository.getFloorsForBuilding(event.room.buildingId);
    List<Room> rooms = await _roomsRepository.getRoomsFromBuildingOnFloor(
        state.idBuilding, state.floor);
    emit(state.copyWith(
      buildings: buildings,
      floors: floors,
      rooms: rooms,
      addEditItemStatus: AddEditItemStatus.editing,
    ));
  }

  Future<void> _onEditingFromItemPreview(AddEditItemEditFromItemPreview event,
      Emitter<AddEditItemState> emit) async {
    List<int> buildings = await _roomsRepository.getAllBuildings();
    Item item = event.item;
    Room room = await _roomsRepository.getRoomWithId(item.idRoom);
    emit(state.copyWith(
      addEditItemStatus: AddEditItemStatus.editing,
      code: item.barcode,
      type: item.type,
      brand: item.brand,
      idBuilding: room.buildingId,
      floor: room.floor,
      room: room.name,
      status: item.state,
      roomOfItem: room,
      buildings: buildings,
    ));
  }

  Future<void> _onEditingFromReport(
      AddEditItemEditFromReport event, Emitter<AddEditItemState> emit) async {}

  void _onCodeChanged(
          AddEditItemCodeChanged event, Emitter<AddEditItemState> emit) =>
      emit(state.copyWith(code: event.code));

  void _onTypeChanged(
          AddEditItemTypeChanged event, Emitter<AddEditItemState> emit) =>
      emit(state.copyWith(type: event.type));

  void _onBrandChanged(
          AddEditItemBrandChanged event, Emitter<AddEditItemState> emit) =>
      emit(state.copyWith(brand: event.brand));

  Future<void> _onBuildingChanged(
      AddEditItemBuildingChanged event, Emitter<AddEditItemState> emit) async {
    List<int> floors =
        await _roomsRepository.getFloorsForBuilding(event.idBuilding);
    emit(state.copyWith(idBuilding: event.idBuilding, floors: floors));
  }

  Future<void> _onFloorChanged(
      AddEditItemFloorChanged event, Emitter<AddEditItemState> emit) async {
    List<Room> rooms = await _roomsRepository.getRoomsFromBuildingOnFloor(
        state.idBuilding, event.floor);
    emit(state.copyWith(floor: event.floor, rooms: rooms));
  }

  void _onRoomChanged(
      AddEditItemRoomChanged event, Emitter<AddEditItemState> emit) {
    emit(state.copyWith(room: event.room));
  }

  void _onStatusChanged(
      AddEditItemStatusChanged event, Emitter<AddEditItemState> emit) {
    emit(state.copyWith(status: event.status));
  }

  Future<void> _onButtonClicked(
      AddEditItemButtonClicked event, Emitter<AddEditItemState> emit) async {
    if (state.isAllInputed()) {
      if (state.addEditItemStatus == AddEditItemStatus.addingInScanner) {
        try {
          print(
              '${state.room} ${state.code} ${state.type} ${state.brand} ${state.status}');
          await _itemsRepository.addItem(
              state.code, state.type, state.brand, state.room, state.status);
          emit(state.copyWith(addEditItemStatus: AddEditItemStatus.added));
        } catch (e) {
          print('źle sie dzieje $e');
        }
      }
    }
  }

  void _onFinish(AddEditItemFinish event, Emitter<AddEditItemState> emit) {
    emit(state.copyWith(
      addEditItemStatus: AddEditItemStatus.initial,
      code: '',
      type: '',
      brand: '',
      idBuilding: -1,
      floor: -3,
      room: -3,
      status: '',
      roomOfItem: Room.empty,
      buildings: const [],
      floors: const [],
      rooms: const [],
    ));
  }
}
