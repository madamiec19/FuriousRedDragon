import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AddReportBloc extends Bloc<AddReportEvent, AddReportState> {
  final IRoomsRepository _roomsRepository;

  AddReportBloc(this._roomsRepository) : super(const AddReportState()) {
    on<AddReportInitial>(_onInitialLoad);
    on<AddReportBuildingChosen>(_onBuildingChosen);
    on<AddReportRoomChosen>(_onRoomChosen);
    on<AddReportButtonClicked>(_onButtonClicked);
  }

  Future<void> _onInitialLoad(
      AddReportInitial event, Emitter<AddReportState> emit) async {
    try {
      final buildings = await _roomsRepository.getAllBuildings();
      emit(state.copyWith(
          buildings: buildings, addReportStatus: AddReportStatus.adding));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _onBuildingChosen(
      AddReportBuildingChosen event, Emitter<AddReportState> emit) async {
    try {
      final rooms = await _roomsRepository.getRoomsFromBuilding(event.building);
      emit(state.copyWith(rooms: rooms, chosenBuilding: event.building));
    } catch (e) {
      print(e.toString());
    }
  }

  void _onRoomChosen(AddReportRoomChosen event, Emitter<AddReportState> emit) =>
      emit(state.copyWith(chosenRoom: event.room));

  void _onButtonClicked(
      AddReportButtonClicked event, Emitter<AddReportState> emit) {
    emit(state.copyWith(addReportStatus: AddReportStatus.added));
  }
}

enum AddReportStatus {
  adding,
  added,
}

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

abstract class AddReportEvent {}

class AddReportInitial extends AddReportEvent {}

class AddReportBuildingChosen extends AddReportEvent {
  final int building;

  AddReportBuildingChosen({required this.building});
}

class AddReportRoomChosen extends AddReportEvent {
  final Room room;

  AddReportRoomChosen({required this.room});
}

class AddReportButtonClicked extends AddReportEvent {}
