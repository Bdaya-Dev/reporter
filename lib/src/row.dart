import 'package:collection/collection.dart';

import 'column_value_assignment.dart';

/// Represents a row in a tabular report.
/// A row can contain nested rows, which corresponds to a change in [rowSpan].
class ReportRow {
  /// maps columnId to an assignment
  final Map<String, ReportColumnValueAssignment> columnAssignments;
  final List<ReportRow> children;
  final Map<String, dynamic> metadata;

  int get rowSpan => children.isEmpty ? 1 : children.map((e) => e.rowSpan).sum;

  const ReportRow({
    required this.columnAssignments,
    this.children = const [],
    this.metadata = const {},
  });
}
