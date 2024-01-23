import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart';
import 'package:injectable/injectable.dart';

part 'add_report_event.dart';
part 'add_report_state.dart';

/// Obsługa rozpoczęcia inwentaryzacji, stworzenia nowego raportu
@Injectable()
class AddReportBloc extends Bloc<AddReportEvent, AddReportState> {
  final IRoomsRepository _roomsRepository;

  AddReportBloc(this._roomsRepository) : super(const AddReportState()) {
    on<AddReportInitial>(_onInitialLoad);
    on<AddReportBuildingChosen>(_onBuildingChosen);
    on<AddReportRoomChosen>(_onRoomChosen);
    on<AddReportButtonClicked>(_onButtonClicked);
  }

  /// Inicjacja obsługi [AddReportPage] - pobranie z repozytorium wszystkich budynków i emisja stanu z listą budynków
  Future<void> _onInitialLoad(
      AddReportInitial event, Emitter<AddReportState> emit) async {
    try {
      List<int> buildings = await _roomsRepository.getAllBuildings();
      emit(state.copyWith(
          buildings: buildings, addReportStatus: AddReportStatus.adding));
    } catch (e) {
      print(e.toString());
    }
  }

  /// Reakcja na wybranie budynku - pobranie listy pomieszczeń z wybranego budynku, emisja stanu z wybranym budynkiem i listą pomieszczeń
  Future<void> _onBuildingChosen(
      AddReportBuildingChosen event, Emitter<AddReportState> emit) async {
    try {
      List<Room> rooms =
          await _roomsRepository.getRoomsFromBuilding(event.building);
      emit(state.copyWith(rooms: rooms, chosenBuilding: event.building));
    } catch (e) {
      print(e.toString());
    }
  }

  /// Reakcja na wybór pomieszczenia - emisja stanu z wybranym pomieszczeniem
  void _onRoomChosen(AddReportRoomChosen event, Emitter<AddReportState> emit) =>
      emit(state.copyWith(chosenRoom: event.room));

  /// Reakcja na przycisk, wyemitowanie zaktualizowanego stanu ze statusem 'dodano raport'
  void _onButtonClicked(
      AddReportButtonClicked event, Emitter<AddReportState> emit) {
    emit(state.copyWith(addReportStatus: AddReportStatus.added));
  }
}
