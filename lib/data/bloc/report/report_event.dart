part of 'report_bloc.dart';

abstract class ReportEvent {}

class ReportInitialized extends ReportEvent {
  final int idRoom;

  ReportInitialized({
    required this.idRoom,
  });
}

class ReportItemAdded extends ReportEvent {
  final Item item;

  ReportItemAdded({required this.item});
}

class ReportSnackBarShowed extends ReportEvent {}

class ReportFinished extends ReportEvent {}
