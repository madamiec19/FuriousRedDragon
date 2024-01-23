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
  final List<Report> reports;
  final List<Room> rooms;
  final List<int> buildings;

  const HistoryDatabaseState({
    this.isAdmin = false,
    this.historyDatabaseStatus = HistoryDatabaseStatus.historyView,
    this.idAdmin = 0,
    this.reports = const [],
    this.rooms = const [],
    this.buildings = const [],
  });

  HistoryDatabaseState copyWith({
    bool? isAdmin,
    HistoryDatabaseStatus? historyDatabaseStatus,
    int? idAdmin,
    List<Report>? reports,
    List<Room>? rooms,
    List<int>? buildings,
  }) =>
      HistoryDatabaseState(
        isAdmin: isAdmin ?? this.isAdmin,
        historyDatabaseStatus:
            historyDatabaseStatus ?? this.historyDatabaseStatus,
        idAdmin: idAdmin ?? this.idAdmin,
        reports: reports ?? this.reports,
        rooms: rooms ?? this.rooms,
        buildings: buildings ?? this.buildings,
      );

  @override
  List<Object?> get props => [
        isAdmin,
        historyDatabaseStatus,
        idAdmin,
        reports,
        rooms,
        buildings,
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
