import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart';
import 'package:injectable/injectable.dart';

part 'add_room_event.dart';
part 'add_room_state.dart';

@Injectable()
class AddRoomBloc extends Bloc<AddRoomEvent, AddRoomState> {
  final IRoomsRepository _roomsRepository;

  AddRoomBloc(this._roomsRepository) : super(const AddRoomState()) {
    on<AddRoomInitial>(_onInitialLoad);
    on<AddRoomBuildingEdited>(_onBuildingEdited);
    on<AddRoomFloorEdited>(_onFloorEdited);
    on<AddRoomRoomEdited>(_onRoomEdited);
    on<AddRoomButtonClicked>(_onButtonClicked);
  }

  void _onInitialLoad(AddRoomInitial event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(
        building: '',
        room: '',
        floor: '',
        addRoomStatus: AddRoomStatus.adding));
  }

  void _onBuildingEdited(
      AddRoomBuildingEdited event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(building: event.building));
  }

  void _onFloorEdited(AddRoomFloorEdited event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(floor: event.floor));
  }

  void _onRoomEdited(AddRoomRoomEdited event, Emitter<AddRoomState> emit) {
    emit(state.copyWith(room: event.room));
  }

  Future<void> _onButtonClicked(
      AddRoomButtonClicked event, Emitter<AddRoomState> emit) async {
    try {
      _roomsRepository.addRoom(int.parse(state.room), int.parse(state.floor),
          int.parse(state.building));
      emit(state.copyWith(addRoomStatus: AddRoomStatus.added));
    } catch (e) {
      print(e);
    }
  }
}
