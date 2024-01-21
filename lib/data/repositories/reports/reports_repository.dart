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
  Stream<Report?> getReportStream() {
    // TODO: implement getReportStream
    throw UnimplementedError();
  }

  @override
  Future<void> updateReport(
      {required int reportId, required String code}) async {
    await _supabaseClient.rpc('add_item_to_report', params: {
      'item_id': code,
      'report_id': reportId,
    });
  }
}
