part of 'report_bloc.dart';

abstract class ReportEvent {}

class ReportInitialized extends ReportEvent {
  final int idAuthor;
  final int idRoom;
  final DateTime createdAt;

  ReportInitialized({
    required this.idAuthor,
    required this.createdAt,
    required this.idRoom,
  });
}

class ReportItemScanned extends ReportEvent {
  final String code;

  ReportItemScanned({required this.code});
}

class ReportFinished extends ReportEvent {}
