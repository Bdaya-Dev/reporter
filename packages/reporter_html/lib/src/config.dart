// ignore_for_file: non_constant_identifier_names

import 'package:html/dom.dart';
import 'package:reporter/reporter.dart';

typedef ElementProcessor = void Function(Element element);

class ReporterHtmlConfig {
  final Node Function(ReportCalculatedRange range)? createElementFromValue;

  ///td or th
  final void Function(Element th, ReportCalculatedRange range)? postProcessCell;
  //tr
  final void Function(Element th, List<ReportCalculatedRange> cells)?
      postProcessRow;
      
  const ReporterHtmlConfig({
    this.createElementFromValue,
    this.postProcessCell,
    this.postProcessRow,
  });
}
