import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/domain/repositories/reports/i_reports_repository.dart';
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart';
import 'package:injectable/injectable.dart';

part 'report_state.dart';
part 'report_event.dart';

/// Obsługa inwentaryzacji, tworzenia raportu
@Injectable()
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final IReportsRepository _reportsRepository;
  final IAuthenticationRepository _authenticationRepository;
  final IRoomsRepository _roomsRepository;

  ReportBloc(this._reportsRepository, this._authenticationRepository,
      this._roomsRepository)
      : super(const ReportState()) {
    on<ReportInitialized>(_onReportInitialized);
    on<ReportItemAdded>(_onReportItemAdded);
    on<ReportFinished>(_onReportFinished);
  }

  /// Inicjacja obsługi inwentaryzacji - pobranie id aktualnego użytkownika, pobranie inwentaryzowanego pomieszczenia,
  /// emisja stanu z pustym (nowym) raportem
  Future<void> _onReportInitialized(
      ReportInitialized event, Emitter<ReportState> emit) async {
    try {
      int authorId = await _authenticationRepository.getCurrentUserId();
      Report newReport =
          await _reportsRepository.addReport(event.idRoom, authorId);
      Room roomFromId = await _roomsRepository.getRoomWithId(event.idRoom);

      emit(state.copyWith(
        reportStatus: ReportStatus.initialized,
        report: newReport.copyWith(room: roomFromId.toString()),
      ));
    } catch (error) {
      print(error.toString());
    }
  }

  /// Reakcja na zakończenie raportu - zamknięcie raportu w repozytorium, emisja pustego stanu
  Future<void> _onReportFinished(
      ReportFinished event, Emitter<ReportState> emit) async {
    try {
      await _reportsRepository.finishReport(state.report.id);
      emit(state.copyWith(
          report: Report.empty, reportStatus: ReportStatus.noReport));
    } catch (error) {
      print(error.toString());
    }
  }

  /// Reakcja na dodanie przedmiotu - aktualizacja raporto o dodany przedmiot w repozytorium,
  /// emisja stanu 'dodano przedmiot' w celu wywoałania informacji w UI o dodaniu przedmiotu
  Future<void> _onReportItemAdded(
      ReportItemAdded event, Emitter<ReportState> emit) async {
    try {
      await _reportsRepository.updateReportWithScannedItem(
          reportId: state.report.id, item: event.item);
      emit(state.copyWith(
        report: await _reportsRepository.getReportWithId(state.report.id),
        reportStatus: ReportStatus.itemAdded,
      ));
      emit(state.copyWith(reportStatus: ReportStatus.initialized));
    } catch (error) {
      print(error.toString());
    }
  }
}
