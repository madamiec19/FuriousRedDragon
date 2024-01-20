import 'package:furious_red_dragon/domain/repositories/entities/report.dart';

abstract class IReportsRepository {
  Future<Report> addReport(int idRoom, int idAuthor);
  Future<void> updateReport({required int reportId, required String code});

  Stream<Report?> getReportStream();
}
