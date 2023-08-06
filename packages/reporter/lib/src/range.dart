class ReportRange {
  final int rowIndex;
  final int columnIndex;

  int get endRowIndex => rowIndex + rowSpan - 1;
  int get endColumnIndex => columnIndex + colSpan - 1;

  final int rowSpan;
  final int colSpan;

  const ReportRange({
    required this.rowIndex,
    required this.columnIndex,
    required this.rowSpan,
    required this.colSpan,
  });

  const ReportRange.single({
    required this.rowIndex,
    required this.columnIndex,
  })  : rowSpan = 1,
        colSpan = 1;

  const ReportRange.fromIndexes({
    required int startRowIndex,
    required int startColumnIndex,
    required int endRowIndex,
    required int endColumnIndex,
  })  : rowSpan = endRowIndex - startRowIndex + 1,
        colSpan = endColumnIndex - startColumnIndex + 1,
        rowIndex = startRowIndex,
        columnIndex = startColumnIndex;

  ReportRange copyWith({
    int? rowIndex,
    int? columnIndex,
    int? rowSpan,
    int? colSpan,
  }) {
    return ReportRange(
      rowIndex: rowIndex ?? this.rowIndex,
      columnIndex: columnIndex ?? this.columnIndex,
      rowSpan: rowSpan ?? this.rowSpan,
      colSpan: colSpan ?? this.colSpan,
    );
  }

  ReportRange operator +(ReportRange other) {
    return ReportRange(
      rowIndex: rowIndex + other.rowIndex,
      columnIndex: columnIndex + other.columnIndex,
      rowSpan: rowSpan + other.rowSpan,
      colSpan: colSpan + other.colSpan,
    );
  }

  ReportRange shiftRowsBy(int rows) {
    return copyWith(
      rowIndex: rowIndex + rows,
    );
  }

  ReportRange shiftColumnsBy(int columns) {
    return copyWith(
      columnIndex: columnIndex + columns,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportRange &&
        other.rowIndex == rowIndex &&
        other.columnIndex == columnIndex &&
        other.rowSpan == rowSpan &&
        other.colSpan == colSpan;
  }

  @override
  int get hashCode {
    return rowIndex.hashCode ^
        columnIndex.hashCode ^
        rowSpan.hashCode ^
        colSpan.hashCode;
  }

  @override
  String toString() {
    return '[$rowIndex..$endRowIndex][$columnIndex..$endColumnIndex]';
  }
}
