import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/domain/repositories/items/i_items_repository.dart';
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart';
import 'package:injectable/injectable.dart';

class ReportOverviewState extends Equatable {
  final Report report;
  final List<Item> itemsFromReportedRoom;

  const ReportOverviewState({
    this.report = Report.empty,
    this.itemsFromReportedRoom = const [],
  });

  ReportOverviewState copyWith({
    Report? report,
    List<Item>? itemsFromReportedRoom,
  }) =>
      ReportOverviewState(
        report: report ?? this.report,
        itemsFromReportedRoom:
            itemsFromReportedRoom ?? this.itemsFromReportedRoom,
      );

  @override
  List<Object?> get props => [
        report,
        itemsFromReportedRoom,
      ];
}

abstract class ReportOverviewEvent {}

class ReportOverviewInit extends ReportOverviewEvent {
  final Report report;

  ReportOverviewInit({required this.report});
}

class ReportOverviewClose extends ReportOverviewEvent {}

@Injectable()
class ReportOverviewBloc
    extends Bloc<ReportOverviewEvent, ReportOverviewState> {
  final IRoomsRepository _roomsRepository;

  ReportOverviewBloc(this._roomsRepository)
      : super(const ReportOverviewState()) {
    on<ReportOverviewInit>(_onReportOverviewInit);
    on<ReportOverviewClose>(_onReportOverviewClose);
  }

  Future<void> _onReportOverviewInit(
      ReportOverviewInit event, Emitter<ReportOverviewState> emit) async {
    try {
      emit(state.copyWith(report: event.report));
      Room reportedRoom =
          await _roomsRepository.getRoomWithId(state.report.roomId);
      List<Item> itemsFromReportedRoom = reportedRoom.items;
      emit(state.copyWith(itemsFromReportedRoom: itemsFromReportedRoom));
    } catch (e) {
      print(e.toString());
    }
  }

  void _onReportOverviewClose(
      ReportOverviewClose event, Emitter<ReportOverviewState> emit) {
    emit(state.copyWith(report: Report.empty, itemsFromReportedRoom: []));
  }
}
