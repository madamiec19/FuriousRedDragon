import 'dart:convert';

import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/domain/repositories/reports/i_reports_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IReportsRepository)
class ReportsRepository implements IReportsRepository {
  final SupabaseClient _supabaseClient;

  ReportsRepository(this._supabaseClient);

  @override
  Future<Report> addReport(int idRoom, int idAuthor) async {
    final response = await _supabaseClient.from('reports').insert([
      {
        'author_id': idAuthor,
        'room_id': idRoom,
        'is_completed': false,
      }
    ]).select();
    Report report = Report.fromJson(response[0]);
    return report;
  }

  @override
  Future<List<Report>> getReports() async {
    final response = await _supabaseClient
        .from('reports')
        .select('*')
        .order('created_at')
        .limit(10);
    List<Report> reports = [];
    print(response);
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
  }

  @override
  Future<void> updateReportWithScannedItem(
      {required int reportId, required Item item}) async {
    await _supabaseClient.rpc('add_item_to_report', params: {
      'item_id': item.toJson(),
      'report_id': reportId,
    });
  }

  @override
  Future<void> finishReport(int reportId) async {
    final response = await _supabaseClient
        .from('reports')
        .update({'is_completed': true}).eq('id', reportId);
  }

  @override
  Future<Report> getReportWithId(int id) async {
    final response =
        await _supabaseClient.from('reports').select('*').eq('id', id).single();
    return Report.fromJson(response);
  }
}
