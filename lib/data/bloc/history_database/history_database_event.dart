part of 'history_database_bloc.dart';

abstract class HistoryDatabaseEvent {}

class HistoryDatabaseInitialCheckRequest extends HistoryDatabaseEvent {}

class HistoryDatabaseDatabaseMenuChosen extends HistoryDatabaseEvent {}

class HistoryDatabaseHistoryMenuChosen extends HistoryDatabaseEvent {}
