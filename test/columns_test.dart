import 'package:reporter/reporter.dart';
import 'package:test/test.dart';

void main() {
  group('Columns', () {
    group('Depth', () {
      test('no children', () {
        final c = ReportColumn.nameOnly(name: 'a');
        expect(c.maxDepth, 1);
      });
      test('one child', () {
        final c = ReportColumn.nameOnly(
          name: 'a',
          children: [
            ReportColumn.nameOnly(name: 'b'),
          ],
        );
        expect(c.maxDepth, 2);
      });
      test('nested children', () {
        final c = ReportColumn.nameOnly(
          name: 'a',
          children: [
            ReportColumn.nameOnly(name: 'b', children: [
              ReportColumn.nameOnly(
                name: 'c',
              ),
            ]),
          ],
        );
        expect(c.maxDepth, 3);
      });
    });
    test('generateColumnMap', () {
      final map = ReportColumn.generateColumnMap([
        ReportColumn.nameOnly(
          name: 'a',
          children: [
            ReportColumn.nameOnly(name: 'b', children: [
              ReportColumn.nameOnly(
                name: 'c',
              ),
            ]),
          ],
        ),
        ReportColumn.nameOnly(
          name: 'd',
          children: [
            ReportColumn.nameOnly(name: 'e', children: [
              ReportColumn.nameOnly(
                name: 'f',
              ),
            ]),
          ],
        ),
      ]);
      expect(map.length, 6);
    });
  });
}
