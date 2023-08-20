import 'package:reporter/src/calculated_range.dart';
import 'package:reporter/src/column.dart';
import 'package:reporter/src/row.dart';

class TableCalculationInfo {
  final List<ReportRow> rows;
  final List<ReportColumn> columns;
  final List<ReportCalculatedRange> headerCells;
  final List<ReportCalculatedRange> bodyCells;

  final int headerRowSpan;
  final int bodyRowSpan;
  final int columnSpan;

  const TableCalculationInfo({
    required this.rows,
    required this.columns,
    required this.headerCells,
    required this.bodyCells,
    required this.headerRowSpan,
    required this.columnSpan,
    required this.bodyRowSpan,
  });
}
