import 'package:collection/collection.dart';
import 'package:reporter/reporter.dart';

/// A utility class for generating tabular reports (like spreadsheets)
/// from arbitrary data.
class TabularReporter {
  static List<ReportCalculatedRange> calculateHeaderCells({
    required List<ReportColumn> columns,
    int offsetRowIndex = 0,
    int offsetColumnIndex = 0,
  }) {
    if (columns.isEmpty) {
      return [];
    }

    final parents = ReportColumn.generateParentsMap(columns);
    final allColumns = ReportColumn.generateColumnMap(columns);
    final res = <ReportCalculatedRange>[];
    _calculateHeaderCells(
      allColumns: allColumns,
      columns: columns,
      offsetColumnIndex: offsetColumnIndex,
      offsetRowIndex: offsetRowIndex,
      parents: parents,
      res: res,
    );
    return res;
  }

  static void _calculateHeaderCells({
    required List<ReportColumn> columns,
    required List<ReportCalculatedRange> res,
    required Map<String, ReportColumn> allColumns,
    required Map<String, Set<String>> parents,
    required int offsetRowIndex,
    required int offsetColumnIndex,
  }) {
    if (columns.isEmpty) {
      return;
    }
    var rowIndex = offsetRowIndex;
    var columnIndex = offsetColumnIndex;
    final maxDepth = columns.map((e) => e.maxDepth).max;
    for (var column in columns) {
      final colSpan = column.columnSpan;
      final rowSpan = maxDepth - column.maxDepth + 1;
      final columnIds = {
        ...?parents[column.id],
        column.id,
      };
      res.add(
        ReportCalculatedRange(
          range: ReportRange(
            rowIndex: rowIndex,
            colSpan: colSpan,
            columnIndex: columnIndex,
            rowSpan: rowSpan,
          ),
          columnIds: columnIds,
          directColumnId: column.id,
          value: column.name,
          metadata: {
            r'isColumn': true,
            for (var c in columnIds.map((e) => allColumns[e]).whereNotNull())
              ...c.metadata,
          },
        ),
      );
      _calculateHeaderCells(
        allColumns: allColumns,
        columns: column.children,
        offsetRowIndex: rowIndex + 1,
        offsetColumnIndex: columnIndex,
        parents: parents,
        res: res,
      );

      columnIndex += colSpan;
    }
  }

  /// Takes the rows and columns and transforms them to ranges with values.
  static List<ReportCalculatedRange> calculateCells({
    required List<ReportRow> rows,
    required List<ReportColumn> columns,
    int offsetRowIndex = 0,
    int offsetColumnIndex = 0,
  }) {
    if (rows.isEmpty || columns.isEmpty) {
      return [];
    }
    final leafColumns = ReportColumn.getColumnsWithNoChildren(columns).toList();
    final reverseColumnIndex =
        leafColumns.asMap().map((key, value) => MapEntry(value.id, key));
    final leafMap = Map.fromEntries(leafColumns.map((e) => MapEntry(e.id, e)));
    final parentsMap = ReportColumn.generateParentsMap(columns);
    //map column to its parents

    final res = <ReportCalculatedRange>[];
    _calculateCells(
      leafMap: leafMap,
      parentsMap: parentsMap,
      res: res,
      reverseColumnIndex: reverseColumnIndex,
      rows: rows,
      offsetColumnIndex: offsetColumnIndex,
      offsetRowIndex: offsetRowIndex,
    );
    return res;
  }

  static void _calculateCells({
    required Map<String, ReportColumn> leafMap,
    required List<ReportRow> rows,
    required List<ReportCalculatedRange> res,
    required Map<String, int> reverseColumnIndex,
    required Map<String, Set<String>> parentsMap,
    required int offsetRowIndex,
    required int offsetColumnIndex,
  }) {
    int visibleRowIndex = offsetRowIndex;
    for (var row in rows) {
      for (var assignmentEntry in row.columnAssignments.entries) {
        final columnId = assignmentEntry.key;
        final column = leafMap[columnId];
        final columnIndex = reverseColumnIndex[columnId];
        if (column == null || columnIndex == null) {
          continue;
        }

        res.add(
          ReportCalculatedRange(
            directColumnId: columnId,
            metadata: assignmentEntry.value.metadata,
            value: assignmentEntry.value.value,
            columnIds: {
              ...?parentsMap[columnId],
              columnId,
            },
            range: ReportRange(
              rowIndex: visibleRowIndex,
              columnIndex: offsetColumnIndex + columnIndex,
              rowSpan: row.rowSpan,
              colSpan: column.columnSpan,
            ),
          ),
        );
      }
      //repeat the process for child rows
      _calculateCells(
        rows: row.children,
        leafMap: leafMap,
        parentsMap: parentsMap,
        res: res,
        reverseColumnIndex: reverseColumnIndex,
        offsetColumnIndex: offsetColumnIndex,
        offsetRowIndex: visibleRowIndex,
      );

      visibleRowIndex += row.rowSpan;
    }
  }

  /// makes sure all the ranges are single, for cases where Excel does't want the data merged.
  /// Note that this keeps the metadata the same for all the split cells.
  List<ReportCalculatedRange> enforceSingleCell(
    Iterable<ReportCalculatedRange> ranges, {
    bool splitCellsAreEmpty = false,
  }) {
    final res = <ReportCalculatedRange>[];
    for (var element in ranges) {
      final range = element.range;
      if (range.rowSpan <= 1 && range.colSpan <= 1) {
        res.add(element);
        continue;
      }
      //split
      for (var r = 0; r < range.rowSpan; r++) {
        for (var c = 0; c < range.colSpan; c++) {
          res.add(
            element
                .copyWith(
                  range: ReportRange.single(
                    rowIndex: range.rowIndex + r,
                    columnIndex: range.columnIndex + c,
                  ),
                )
                .copyWithValue(
                  splitCellsAreEmpty && (r > 0 || c > 0) ? null : element.value,
                ),
          );
        }
      }
    }
    return res;
  }
}
