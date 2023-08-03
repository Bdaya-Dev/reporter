// ignore_for_file: non_constant_identifier_names

import 'package:html/dom.dart';
import 'package:reporter/reporter.dart';

typedef ElementProcessor = void Function(Element element);

class ReporterHtmlConfig {
  final Element Function(ReportCalculatedRange range)? createElementFromValue;

  const ReporterHtmlConfig({
    this.createElementFromValue,
  });
}
