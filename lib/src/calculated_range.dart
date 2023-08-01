import 'range.dart';

/// Represents a range with useful information, like the value and the metadata.
class ReportCalculatedRange {
  /// The range
  final ReportRange range;

  /// All the columns this cell belongs to
  final Set<String> columnIds;

  /// The column that's directly above this cell
  final String directColumnId;

  final Object? value;
  final Map<String, dynamic> metadata;

  const ReportCalculatedRange({
    required this.range,
    required this.columnIds,
    required this.directColumnId,
    required this.value,
    this.metadata = const {},
  });

  ReportCalculatedRange copyWith({
    ReportRange? range,
    Set<String>? columnIds,
    String? directColumnId,
    Object? value,
    Map<String, dynamic>? metadata,
  }) {
    return ReportCalculatedRange(
      range: range ?? this.range,
      columnIds: columnIds ?? this.columnIds,
      directColumnId: directColumnId ?? this.directColumnId,
      value: value ?? this.value,
      metadata: metadata ?? this.metadata,
    );
  }

  ReportCalculatedRange copyWithValue(Object? value) {
    return ReportCalculatedRange(
      range: range,
      columnIds: columnIds,
      directColumnId: directColumnId,
      value: value,
      metadata: metadata,
    );
  }

  @override
  String toString() {
    return '$range = $value ~ $metadata';
  }
}
