import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/domain/repositories/reports/i_reports_repository.dart';
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart';
import 'package:injectable/injectable.dart';

part 'report_state.dart';
part 'report_event.dart';

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
    on<ReportSnackBarShowed>(_onReportSnackBarShowed);
  }

  void _onReportSnackBarShowed(
      ReportSnackBarShowed event, Emitter<ReportState> emit) {
    emit(state.copyWith(reportStatus: ReportStatus.initialized));
  }

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

  Future<void> _onReportInitialized(
      ReportInitialized event, Emitter<ReportState> emit) async {
    try {
      int authorId = await _authenticationRepository.getCurrentUserId();
      final reportResponse =
          await _reportsRepository.addReport(event.idRoom, authorId);
      final room = await _roomsRepository.getRoomWithId(event.idRoom);
      print('dsadasd ${room.floor}');
      emit(state.copyWith(
        reportStatus: ReportStatus.initialized,
        report: reportResponse.copyWith(room: room.toString()),
      ));
    } catch (error) {
      print(error.toString());
    }
  }
}
