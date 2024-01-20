import 'package:furious_red_dragon/domain/repositories/entities/report.dart';

abstract class IReportsRepository {
  Future<void> addReport(int idRoom, int idAuthor);
  Future<void> updateReport({required int reportId});

  Stream<Report?> getReportStream();
}
