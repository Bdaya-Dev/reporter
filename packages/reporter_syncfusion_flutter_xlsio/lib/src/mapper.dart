import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:reporter/reporter.dart';

import 'config.dart';

class TabularReporterSfExcel {
  static Range mapFromCalculatedRange({
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

  static void assignCells({
    required Worksheet sheet,
    required List<ReportCalculatedRange> cells,
    AssignCellsConfig config = const AssignCellsConfig(),
  }) {
    final func = config.assignValue;
    for (var cell in cells) {
      final range = mapFromCalculatedRange(
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
