import 'package:reporter/reporter.dart';
import 'package:html/dom.dart';
import 'package:collection/collection.dart';
import 'config.dart';

/// An html generator for [TabularReporter]
class TabularReporterHtml {
  static Element _registerElement(String tag, {Element? parent}) {
    final e = Element.tag(tag);
    if (parent != null) {
      parent.append(e);
    }
    return e;
  }

  static Element _generateFromCells({
    required List<ReportCalculatedRange> cells,
    required String resElementTag,
    required String cellElementTag,
    ReporterHtmlConfig config = const ReporterHtmlConfig(),
  }) {
    final res = _registerElement(resElementTag);
    if (cells.isEmpty) {
      return res;
    }
    final rangesGrouped =
        cells.groupListsBy((element) => element.range.rowIndex);
    final minKey = rangesGrouped.keys.min;
    final maxKey = rangesGrouped.keys.max;
    final maxColIndex = cells.map((e) => e.range.columnIndex).max;
    for (var rowIndex = minKey; rowIndex <= maxKey; rowIndex++) {
      final row = rangesGrouped[rowIndex];
      if (row == null) {
        continue;
      }
      final colGroups =
          row.groupListsBy((element) => element.range.columnIndex);
      final minColKey = colGroups.keys.min;
      final tr = _registerElement('tr', parent: res);

      for (var colIndex = minColKey; colIndex <= maxColIndex; colIndex++) {
        final cells = colGroups[colIndex];
        if (cells == null) {
          continue;
        }

        if (cells.length > 1) {
          throw ArgumentError.value('duplicate cells are not allowed');
        }
        final cellElement = _registerElement(cellElementTag, parent: tr);
        final cell = cells.first;

        cellElement.attributes['rowspan'] = cell.range.rowSpan.toString();
        cellElement.attributes['colspan'] = cell.range.colSpan.toString();
        final valueNode = config.createElementFromValue?.call(cell);
        if (valueNode != null) {
          cellElement.append(valueNode);
        } else {
          cellElement.text = cell.value.toString();
        }
        config.postProcessCell?.call(cellElement, cell);
      }
      config.postProcessRow?.call(tr, cells);
    }
    return res;
  }

  static Element generateFullTableFromRowsAndColumns({
    required List<ReportRow> rows,
    required List<ReportColumn> columns,
    ReporterHtmlConfig config = const ReporterHtmlConfig(),
  }) {
    final info = TabularReporter.calculateFullTable(rows: rows, columns: columns);
    
    
    return generateFullTableFromCells(
      headerCells: info.headerCells,
      bodyCells: info.bodyCells,
      config: config,
    );
  }

  ///Generates a table with thead and tbody by calling [generateTableHead] and [generateTableBody] respectively.
  static Element generateFullTableFromCells({
    required List<ReportCalculatedRange> headerCells,
    required List<ReportCalculatedRange> bodyCells,
    ReporterHtmlConfig config = const ReporterHtmlConfig(),
  }) {
    final thead = generateTableHead(cells: headerCells, config: config);
    final tbody = generateTableHead(cells: bodyCells, config: config);
    final table = Element.tag('table');
    table.append(thead);
    table.append(tbody);
    return table;
  }

  ///Returns a thead element
  static Element generateTableHead({
    required List<ReportCalculatedRange> cells,
    ReporterHtmlConfig config = const ReporterHtmlConfig(),
  }) {
    return _generateFromCells(
      cells: cells,
      resElementTag: 'thead',
      cellElementTag: 'th',
      config: config,
    );
  }

  ///Returns a tbody element
  static Element generateTableBody({
    required List<ReportCalculatedRange> cells,
    ReporterHtmlConfig config = const ReporterHtmlConfig(),
  }) {
    return _generateFromCells(
      cells: cells,
      resElementTag: 'tbody',
      cellElementTag: 'td',
    );
  }
}
