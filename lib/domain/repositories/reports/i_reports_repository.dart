import 'package:furious_red_dragon/domain/repositories/entities/item.dart';
import 'package:furious_red_dragon/domain/repositories/entities/report.dart';

abstract class IReportsRepository {
  Future<Report> addReport(int idRoom, int idAuthor);
  Future<void> updateReportWithScannedItem(
      {required int reportId, required Item item});

  Future<List<Report>> getAllReports();

  Future<Report> getReportWithId(int id);

  Future<void> finishReport(int reportId);

  Future<List<Report>> getReportForRoom(int roomId);
}
