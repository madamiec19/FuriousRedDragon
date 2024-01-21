import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/domain/repositories/reports/i_reports_repository.dart';
import 'package:injectable/injectable.dart';

part 'report_state.dart';
part 'report_event.dart';

@Injectable()
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final IReportsRepository _reportsRepository;
  final IAuthenticationRepository _authenticationRepository;

  ReportBloc(this._reportsRepository, this._authenticationRepository)
      : super(const ReportState()) {
    on<ReportInitialized>(_onReportInitialized);
    on<ReportItemScanned>(_onReportItemScanned);
  }

  void _onReportItemScanned(
      ReportItemScanned event, Emitter<ReportState> emit) async {
    try {
      _reportsRepository.updateReport(
          reportId: state.report.id, code: event.code);
    } catch (error) {
      print(error.toString());
    }
  }

  void _onReportInitialized(
      ReportInitialized event, Emitter<ReportState> emit) async {
    try {
      int id = await _authenticationRepository.getCurrentUserId();

      var response = await _reportsRepository.addReport(event.idRoom, id);

      emit(state.copyWith(
          reportStatus: ReportStatus.initialized, report: response));
    } catch (error) {
      print(error.toString());
    }
  }
}
