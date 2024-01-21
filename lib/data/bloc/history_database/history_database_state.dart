part of 'history_database_bloc.dart';

enum HistoryDatabaseStatus {
  historyView,
  databaseView,
  localizationsAdminView,
  usersAdminView,
  addUserAdminView,
}

class HistoryDatabaseState extends Equatable {
  final bool isAdmin;
  final HistoryDatabaseStatus historyDatabaseStatus;
  final int idAdmin;
  final List<Report>? reports;

  const HistoryDatabaseState({
    this.isAdmin = false,
    this.historyDatabaseStatus = HistoryDatabaseStatus.historyView,
    this.idAdmin = 0,
    this.reports,
  });

  HistoryDatabaseState copyWith(
          {bool? isAdmin,
          HistoryDatabaseStatus? historyDatabaseStatus,
          int? idAdmin,
          List<Report>? reports}) =>
      HistoryDatabaseState(
        isAdmin: isAdmin ?? this.isAdmin,
        historyDatabaseStatus:
            historyDatabaseStatus ?? this.historyDatabaseStatus,
        idAdmin: idAdmin ?? this.idAdmin,
        reports: reports ?? this.reports,
      );

  @override
  List<Object?> get props => [
        isAdmin,
        historyDatabaseStatus,
        idAdmin,
        reports,
      ];

  int getAdminId() => idAdmin;

  bool isHistoryMenuChosen() =>
      historyDatabaseStatus == HistoryDatabaseStatus.historyView;
  bool isDatabaseMenuChosen() =>
      historyDatabaseStatus == HistoryDatabaseStatus.databaseView;
  bool isLocalizationsViewChosen() =>
      historyDatabaseStatus == HistoryDatabaseStatus.localizationsAdminView;
  bool isUsersViewChosen() =>
      historyDatabaseStatus == HistoryDatabaseStatus.usersAdminView;
  bool isAddUserViewChosen() =>
      historyDatabaseStatus == HistoryDatabaseStatus.addUserAdminView;
}
