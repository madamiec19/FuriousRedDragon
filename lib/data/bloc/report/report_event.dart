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
  final Item item;

  ReportItemScanned({required this.item});
}

class ReportRefresh extends ReportEvent {}

class ReportFinished extends ReportEvent {}

class ReportItemTesting extends ReportEvent {}
