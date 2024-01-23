part of 'add_report_bloc.dart';

/// Eventy możliwe do zajścia w [AddReportPage]

abstract class AddReportEvent {}

class AddReportInitial extends AddReportEvent {}

class AddReportBuildingChosen extends AddReportEvent {
  final int building;

  AddReportBuildingChosen({required this.building});
}

class AddReportRoomChosen extends AddReportEvent {
  final Room room;

  AddReportRoomChosen({required this.room});
}

class AddReportButtonClicked extends AddReportEvent {}
