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

class ReportItemAdded extends ReportEvent {
  final Item item;

  ReportItemAdded({required this.item});
}

class ReportSnackBarShowed extends ReportEvent {}

class ReportFinished extends ReportEvent {}
