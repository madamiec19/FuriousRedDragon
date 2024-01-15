import 'package:furious_red_dragon/domain/repositories/entities/report.dart';

abstract class IReportsRepository {
  Future<void> addReport();
  Future<void> updateReport({required int reportId});

  Stream<Report?> getReportStream();
}
