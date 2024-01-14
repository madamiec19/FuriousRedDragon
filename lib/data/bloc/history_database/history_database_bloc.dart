import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/items/i_items_repository.dart';
import 'package:injectable/injectable.dart';

part 'history_database_state.dart';
part 'history_database_event.dart';

@Injectable()
class HistoryDatabaseBloc
    extends Bloc<HistoryDatabaseEvent, HistoryDatabaseState> {
  final IItemsRepository _itemsRepository;
  final IAuthenticationRepository _authenticationRepository;

  HistoryDatabaseBloc(this._itemsRepository, this._authenticationRepository)
      : super(HistoryDatabaseState()) {
    on<HistoryDatabaseInitialCheckRequest>(_onInitialLoad);
    on<HistoryDatabaseDatabaseMenuChosen>(_onDatabaseMenuChosen);
    on<HistoryDatabaseHistoryMenuChosen>(_onHistoryMenuChosen);
    on<HistoryDatabaseAdminLocalizationsButtonClicked>(
        _onAdminLocalizationsButtonClicked);
    on<HistoryAdminUsersButtonClicked>(_onAdminUsersButtonClicked);
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
        emit(state.copyWith(isAdmin: true));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  void _onDatabaseMenuChosen(HistoryDatabaseDatabaseMenuChosen event,
      Emitter<HistoryDatabaseState> emit) {
    emit(state.copyWith(
        historyDatabaseStatus: HistoryDatabaseStatus.databaseView));
  }

  void _onHistoryMenuChosen(HistoryDatabaseHistoryMenuChosen event,
      Emitter<HistoryDatabaseState> emit) {
    emit(state.copyWith(
        historyDatabaseStatus: HistoryDatabaseStatus.historyView));
  }
}
