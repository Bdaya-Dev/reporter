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
}
