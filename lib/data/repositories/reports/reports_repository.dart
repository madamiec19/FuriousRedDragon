import 'package:furious_red_dragon/domain/repositories/entities/report.dart';
import 'package:furious_red_dragon/domain/repositories/reports/i_reports_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IReportsRepository)
class ReportsRepository implements IReportsRepository {
  final SupabaseClient _supabaseClient;

  ReportsRepository(this._supabaseClient);

  @override
  Future<int> addReport(int idRoom, int idAuthor) async {
    final response = await _supabaseClient.from('reports').insert([
      {
        'author_id': idAuthor,
        'room_id': idRoom,
        'is_finished': false,
      }
    ]).select();
    print(response[0]);
    return response[0];
  }

  @override
  Stream<Report?> getReportStream() {
    // TODO: implement getReportStream
    throw UnimplementedError();
  }

  @override
  Future<void> updateReport({required int reportId}) {
    // TODO: implement updateReport
    throw UnimplementedError();
  }
}
