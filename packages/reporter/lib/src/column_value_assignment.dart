class ReportColumnValueAssignment {
  /// The cell value
  final dynamic value;

  /// Metadata for customization
  final Map<String, dynamic> metadata;

  const ReportColumnValueAssignment({
    required this.value,
    this.metadata = const {},
  });

  @override
  String toString() => value.toString();
}
