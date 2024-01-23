import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/domain/repositories/reports/i_reports_repository.dart';
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart';
import 'package:injectable/injectable.dart';

part 'history_database_state.dart';
part 'history_database_event.dart';

/// Obsługa okna 'Historia'
@Injectable()
class HistoryDatabaseBloc
    extends Bloc<HistoryDatabaseEvent, HistoryDatabaseState> {
  final IRoomsRepository _roomsRepository;
  final IAuthenticationRepository _authenticationRepository;
  final IReportsRepository _reportsRepository;

  HistoryDatabaseBloc(this._roomsRepository, this._authenticationRepository,
      this._reportsRepository)
      : super(const HistoryDatabaseState()) {
    on<HistoryDatabaseInitialCheckRequest>(_onInitialLoad);
    on<HistoryDatabaseDatabaseMenuChosen>(_onDatabaseMenuChosen);
    on<HistoryDatabaseHistoryMenuChosen>(_onHistoryMenuChosen);
    on<HistoryDatabaseAdminLocalizationsButtonClicked>(
        _onAdminLocalizationsButtonClicked);
    on<HistoryAdminUsersButtonClicked>(_onAdminUsersButtonClicked);
    on<HistoryAdminAddUserButtonClicked>(_onAdminAddUserButtonClicked);
  }

  void _onAdminAddUserButtonClicked(HistoryAdminAddUserButtonClicked event,
      Emitter<HistoryDatabaseState> emit) {
    emit(state.copyWith(
      historyDatabaseStatus: HistoryDatabaseStatus.addUserAdminView,
    ));
  }

  void _onAdminUsersButtonClicked(HistoryAdminUsersButtonClicked event,
      Emitter<HistoryDatabaseState> emit) {
    emit(state.copyWith(
        historyDatabaseStatus: HistoryDatabaseStatus.usersAdminView));
  }

  void _onAdminLocalizationsButtonClicked(
      HistoryDatabaseAdminLocalizationsButtonClicked event,
      Emitter<HistoryDatabaseState> emit) {
    emit(state.copyWith(
        historyDatabaseStatus: HistoryDatabaseStatus.localizationsAdminView));
  }

  Future<void> _onInitialLoad(HistoryDatabaseInitialCheckRequest event,
      Emitter<HistoryDatabaseState> emit) async {
    try {
      if (await _authenticationRepository.getCurrentUserRole() == 'admin') {
        emit(state.copyWith(
            isAdmin: true,
            historyDatabaseStatus: HistoryDatabaseStatus.historyView));
      } else {
        emit(state.copyWith(
            isAdmin: false,
            historyDatabaseStatus: HistoryDatabaseStatus.historyView));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _onDatabaseMenuChosen(HistoryDatabaseDatabaseMenuChosen event,
      Emitter<HistoryDatabaseState> emit) async {
    emit(state.copyWith(
      historyDatabaseStatus: HistoryDatabaseStatus.databaseView,
    ));
    final rooms = await _roomsRepository.getAllRooms();
    emit(state.copyWith(rooms: rooms));
  }

  Future<void> _onHistoryMenuChosen(HistoryDatabaseHistoryMenuChosen event,
      Emitter<HistoryDatabaseState> emit) async {
    emit(state.copyWith(
        historyDatabaseStatus: HistoryDatabaseStatus.historyView));
    final reports = await _reportsRepository.getAllReports();
    emit(state.copyWith(reports: reports));
  }
}
