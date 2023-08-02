import 'package:collection/collection.dart';

/// Represents a column in a tabular report.
/// A column can contain nested columns, which corresponds to a change in [columnSpan].
class ReportColumn {
  final String id;
  final String name;
  final List<ReportColumn> children;
  final Map<String, dynamic> metadata;

  int get columnSpan =>
      children.isEmpty ? 1 : children.map((e) => e.columnSpan).sum;

  int get maxDepth =>
      (children.isEmpty ? 0 : children.map((e) => e.maxDepth).max) + 1;

  /// A convenience constructor when the id is the same as the name, and they are both unique.
  const ReportColumn.nameOnly({
    required this.name,
    this.children = const [],
    this.metadata = const {},
  }) : id = name;

  const ReportColumn({
    required this.id,
    required this.name,
    this.children = const [],
    this.metadata = const {},
  });

  static Iterable<ReportColumn> _expand(ReportColumn column) sync* {
    yield column;
    yield* column.children.map(_expand).flattened;
  }

  static Map<String, ReportColumn> generateColumnMap(
    Iterable<ReportColumn> columns,
  ) {
    return Map.fromEntries(
      columns.expand(_expand).map((e) => MapEntry(e.id, e)),
    );
  }

  static Iterable<ReportColumn> getColumnsWithNoChildren(
    Iterable<ReportColumn> columns,
  ) {
    return columns.expand(
      (e) => e.children.isEmpty ? [e] : getColumnsWithNoChildren(e.children),
    );
  }

  static Map<String, Set<String>> generateParentsMap(
    Iterable<ReportColumn> columns,
  ) {
    final res = <String, Set<String>>{};
    for (var c in columns) {
      _fillParentsMap(c, res);
    }
    return res;
  }

  static void _fillParentsMap(
    ReportColumn parent,
    Map<String, Set<String>> res,
  ) {
    final parentParents = res[parent.id] ??= {};
    for (var child in parent.children) {
      final parents = res[child.id] ??= {};
      parents.addAll(parentParents);
      parents.add(parent.id);
      _fillParentsMap(child, res);
    }
  }
}

// class TypedReportColumn<T> extends ReportColumn {
//   const TypedReportColumn.fromAssignment({
//     required super.id,
//     required super.name,
//     required this.getAssigment,
//     super.children,
//     super.metadata,
//   });

//   TypedReportColumn({
//     required super.id,
//     required super.name,
//     required dynamic Function(T item) getValue,
//     super.children,
//     super.metadata,
//   }) : getAssigment = ((T item) =>
//             ReportColumnValueAssignment(value: getValue(item)));

//   final ReportColumnValueAssignment? Function(T item) getAssigment;
// }
