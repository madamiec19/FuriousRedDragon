part of 'report_bloc.dart';

enum ReportStatus {
  noReport,
  initialized,
  inProgress,
  itemAdded,
  finished,
}

class ReportState extends Equatable {
  final Report report;
  final ReportStatus reportStatus;

  const ReportState({
    this.report = Report.empty,
    this.reportStatus = ReportStatus.noReport,
  });

  ReportState copyWith({Report? report, ReportStatus? reportStatus}) =>
      ReportState(
        report: report ?? this.report,
        reportStatus: reportStatus ?? this.reportStatus,
      );

  @override
  List<Object?> get props => [report, reportStatus];

  bool isReportInitialized() => reportStatus == ReportStatus.initialized;
}
