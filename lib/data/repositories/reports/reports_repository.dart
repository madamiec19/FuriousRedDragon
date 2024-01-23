import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/domain/repositories/entities/room.dart';
import 'package:furious_red_dragon/domain/repositories/reports/i_reports_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IReportsRepository)
class ReportsRepository implements IReportsRepository {
  final SupabaseClient _supabaseClient;

  ReportsRepository(this._supabaseClient);

  @override
  Future<Report> addReport(int idRoom, int idAuthor) async {
    try {
      final response = await _supabaseClient.from('reports').insert([
        {
          'author_id': idAuthor,
          'room_id': idRoom,
          'is_completed': false,
        }
      ]).select();
      Report report = Report.fromJson(response[0]);
      final roomResponse = await _supabaseClient
          .from('rooms')
          .select('*')
          .eq('id', report.roomId)
          .single();
      Room room = Room.fromJson(roomResponse);
      report = report.copyWith(room: room.toString());
      return report;
    } catch (error) {
      print(error.toString());
    }
    return Report.empty;
  }

  @override
  Future<List<Report>> getAllReports() async {
    try {
      final response = await _supabaseClient
          .from('reports')
          .select('*')
          .order('created_at')
          .limit(10);

      List<Report> reports = [];

      for (var value in response) {
        Report report = Report.fromJson(value);
        final authorResponse = await _supabaseClient
            .from('roles')
            .select('name')
            .eq('id', report.idAuthor)
            .single();
        String author = authorResponse['name'];

        final roomResponse = await _supabaseClient
            .from('rooms')
            .select('*')
            .eq('id', report.roomId)
            .single();
        Room room = Room.fromJson(roomResponse);
        report = report.copyWith(author: author, room: room.toString());
        reports.add(report);
      }
      return reports;
    } catch (error) {
      print(error.toString());
    }
    return [];
  }

  @override
  Future<void> updateReportWithScannedItem(
      {required int reportId, required Item item}) async {
    try {
      await _supabaseClient.rpc('add_item_to_report', params: {
        'item_id': item.toJson(),
        'report_id': reportId,
      });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<void> finishReport(int reportId) async {
    try {
      await _supabaseClient
          .from('reports')
          .update({'is_completed': true}).eq('id', reportId);
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<Report> getReportWithId(int id) async {
    try {
      final response = await _supabaseClient
          .from('reports')
          .select('*')
          .eq('id', id)
          .single();
      return Report.fromJson(response);
    } catch (error) {
      print(error.toString());
    }
    return Report.empty;
  }

  @override
  Future<List<Report>> getReportForRoom(int roomId) async {
    try {
      final response = await _supabaseClient
          .from('reports')
          .select('*')
          .eq('room_id', roomId)
          .order('created_at');

      List<Report> reports = [];

      for (var value in response) {
        Report report = Report.fromJson(value);
        final authorResponse = await _supabaseClient
            .from('roles')
            .select('name')
            .eq('id', report.idAuthor)
            .single();
        String author = authorResponse['name'];

        final roomResponse = await _supabaseClient
            .from('rooms')
            .select('name,floor,id_building')
            .eq('id', report.roomId)
            .single();
        String room =
            'Sala ${roomResponse['name'].toString()}/${roomResponse['floor'].toString()} bud. ${roomResponse['id_building'].toString()}';

        report = report.copyWith(author: author, room: room);
        reports.add(report);
      }
      return reports;
    } catch (error) {
      print(error.toString());
    }
    return [];
  }
}
