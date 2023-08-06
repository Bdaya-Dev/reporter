import 'package:reporter/reporter.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class AssignCellsConfig {
  const AssignCellsConfig({
    this.assignValue,
    this.postAssignValue,
  });

  final void Function(ReportCalculatedRange calculatedRange, Range range)?
      assignValue;
  final void Function(ReportCalculatedRange calculatedRange, Range range)?
      postAssignValue;

  AssignCellsConfig mergeWith(AssignCellsConfig other) {
    return AssignCellsConfig(
      assignValue: assignValue == null && other.assignValue == null
          ? null
          : (calculatedRange, range) {
              if (assignValue != null) {
                assignValue!(calculatedRange, range);
              }
              if (other.assignValue != null) {
                other.assignValue!(calculatedRange, range);
              }
            },
      postAssignValue: postAssignValue == null && other.postAssignValue == null
          ? null
          : (calculatedRange, range) {
              if (postAssignValue != null) {
                postAssignValue!(calculatedRange, range);
              }
              if (other.postAssignValue != null) {
                other.postAssignValue!(calculatedRange, range);
              }
            },
    );
  }
}
