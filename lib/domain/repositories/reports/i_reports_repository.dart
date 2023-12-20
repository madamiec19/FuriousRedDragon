import 'package:furious_red_dragon/data/models/report.dart';

abstract class IReportsRepository {
  Future<void> addReport();
  Future<void> updateReport({required int reportId});

  Stream<Report?> getReportStream();
}
