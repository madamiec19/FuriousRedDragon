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

  const HistoryDatabaseState({
    this.isAdmin = false,
    this.historyDatabaseStatus = HistoryDatabaseStatus.historyView,
  });

  HistoryDatabaseState copyWith(
          {bool? isAdmin, HistoryDatabaseStatus? historyDatabaseStatus}) =>
      HistoryDatabaseState(
        isAdmin: isAdmin ?? this.isAdmin,
        historyDatabaseStatus:
            historyDatabaseStatus ?? this.historyDatabaseStatus,
      );

  @override
  List<Object?> get props => [
        isAdmin,
        historyDatabaseStatus,
      ];

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
