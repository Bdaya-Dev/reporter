import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:reporter/reporter.dart';

import 'config.dart';

class FullAssignmentResults {
  final Range headerRange;
  final Range dataRange;

  final TableCalculationInfo calculationInfo;
  const FullAssignmentResults({
    required this.headerRange,
    required this.dataRange,
    required this.calculationInfo,
  });
}

class TabularReporterSfExcel {
  static Range getExcelSurroundingRange({
    required Worksheet sheet,
    required List<ReportCalculatedRange> ranges,
  }) {
    int minCol = ranges.map((e) => e.range.columnIndex).min;
    int maxCol = ranges.map((e) => e.range.endColumnIndex).max;
    int minRow = ranges.map((e) => e.range.rowIndex).min;
    int maxRow = ranges.map((e) => e.range.endRowIndex).max;
    return sheet.getRangeByIndex(
      minRow + 1,
      minCol + 1,
      maxRow + 1,
      maxCol + 1,
    );
  }

  static Range excelRangeFromCalculatedRange({
    required Worksheet sheet,
    required ReportCalculatedRange range,
  }) {
    //add one to convert from zero-based to one-based index
    return sheet.getRangeByIndex(
      range.range.rowIndex + 1,
      range.range.columnIndex + 1,
      range.range.endRowIndex + 1,
      range.range.endColumnIndex + 1,
    );
  }

  static FullAssignmentResults assignFullTableFromRowsAndColumns({
    required Worksheet sheet,
    required List<ReportRow> rows,
    required List<ReportColumn> columns,
    AssignCellsConfig sharedConfig = const AssignCellsConfig(),
    AssignCellsConfig headerConfig = const AssignCellsConfig(),
    AssignCellsConfig bodyConfig = const AssignCellsConfig(),
    int offsetRows = 0,
    int offsetColumns = 0,
  }) {
    final info = TabularReporter.calculateFullTable(
      rows: rows,
      columns: columns,
      offsetColumnIndex: offsetColumns,
      offsetRowIndex: offsetRows,
    );
    assignFullTableFromCells(
      sheet: sheet,
      headerCells: info.headerCells,
      bodyCells: info.bodyCells,
      sharedConfig: sharedConfig,
      headerConfig: headerConfig,
      bodyConfig: bodyConfig,
    );

    return FullAssignmentResults(
      headerRange: sheet.getRangeByIndex(
        offsetRows + 1,
        offsetColumns + 1,
        offsetRows + info.headerRowSpan,
        offsetColumns + info.columnSpan,
      ),
      dataRange: sheet.getRangeByIndex(
        offsetRows + 1 + info.headerRowSpan,
        offsetColumns + 1,
        offsetRows + info.headerRowSpan + info.bodyRowSpan,
        offsetColumns + info.columnSpan,
      ),
      calculationInfo: info,
    );
  }

  static void assignFullTableFromCells({
    required Worksheet sheet,
    required List<ReportCalculatedRange> headerCells,
    required List<ReportCalculatedRange> bodyCells,
    AssignCellsConfig sharedConfig = const AssignCellsConfig(),
    AssignCellsConfig headerConfig = const AssignCellsConfig(),
    AssignCellsConfig bodyConfig = const AssignCellsConfig(),
  }) {
    assignCells(
      sheet: sheet,
      cells: headerCells,
      config: sharedConfig.mergeWith(headerConfig),
    );
    assignCells(
      sheet: sheet,
      cells: bodyCells,
      config: sharedConfig.mergeWith(bodyConfig),
    );
  }

  static void assignCells({
    required Worksheet sheet,
    required List<ReportCalculatedRange> cells,
    AssignCellsConfig config = const AssignCellsConfig(),
  }) {
    final func = config.assignValue;
    for (var cell in cells) {
      final range = excelRangeFromCalculatedRange(
        range: cell,
        sheet: sheet,
      );
      if (func != null) {
        func(cell, range);
      } else {
        range.setValue(cell.value);
      }
      config.postAssignValue?.call(cell, range);
    }
  }
}
