import 'package:_shared/_shared.dart';
import 'package:_shared_addons/_shared_addons.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:collection/collection.dart';
import 'package:reporter_html/reporter_html.dart';
import 'package:test/test.dart';

void main() {
  group('ReporterHtml', () {
    test('Golden test', () {
      const golden = r'''
<table>
        <thead>
            <tr>
                <th rowspan="3" colspan="1">Client</th>
                <th rowspan="1" colspan="4">payments</th>
            </tr>
            <tr>
                <th rowspan="2" colspan="1">reason</th>
                <th rowspan="2" colspan="1">total to pay</th>
                <th rowspan="1" colspan="2">instances</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">date</th>
                <th rowspan="1" colspan="1">amount</th>
            </tr>
        </thead>
        <thead>
            <tr>
                <th rowspan="6" colspan="1">person1</th>
                <th rowspan="3" colspan="1">project1</th>
                <th rowspan="3" colspan="1">5000.0</th>
                <th rowspan="1" colspan="1">2023-08-01 00:00:00.000</th>
                <th rowspan="1" colspan="1">2000.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">2023-08-15 00:00:00.000</th>
                <th rowspan="1" colspan="1">1500.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">2023-08-30 00:00:00.000</th>
                <th rowspan="1" colspan="1">1500.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">project2</th>
                <th rowspan="1" colspan="1">1000.0</th>
            </tr>
            <tr>
                <th rowspan="2" colspan="1">project3</th>
                <th rowspan="2" colspan="1">4000.0</th>
                <th rowspan="1" colspan="1">2023-09-01 00:00:00.000</th>
                <th rowspan="1" colspan="1">1000.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">2023-09-15 00:00:00.000</th>
                <th rowspan="1" colspan="1">2000.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">person2</th>
                <th rowspan="1" colspan="1">project4</th>
                <th rowspan="1" colspan="1">0.0</th>
            </tr>
        </thead>
    </table>
''';
      final goldenElement = parse(golden).querySelector("table")!;

      final generatedElement =
          TabularReporterHtml.generateFullTableFromRowsAndColumns(
        columns: columns,
        rows: mapDataToRows(sampleData),
      );

      expect(deepEquals(goldenElement, generatedElement), true);
    });
  });
}

bool deepEquals(Element e1, Element e2) {
  final tagsEq =
      e1.namespaceUri == e2.namespaceUri && e1.localName == e2.localName;

  final attrsEq = e1.attributes.length == e2.attributes.length &&
      e1.attributes.entries
          .every((element) => e2.attributes[element.key] == element.value);
  final childrenEq = e1.children.length == e2.children.length &&
      e1.children
          .mapIndexed(
            (index, element) => deepEquals(
              element,
              e2.children[index],
            ),
          )
          .every((element) => element);

  return tagsEq && attrsEq && childrenEq;
}
