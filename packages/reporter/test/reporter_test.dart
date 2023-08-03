import 'package:reporter/reporter.dart';
import 'package:test/test.dart';

import 'models/my_client.dart';
import 'models/my_payment_group.dart';
import 'models/my_payment_instance.dart';

final sampleData = <MyClient>[
  MyClient(
    name: 'person1',
    paymentGroups: [
      MyPaymentGroup(
        reason: 'project1',
        totalToPay: 5000,
        paymentInstances: [
          MyPaymentInstance(amount: 2000, date: DateTime(2023, 08, 01)),
          MyPaymentInstance(amount: 1500, date: DateTime(2023, 08, 15)),
          MyPaymentInstance(amount: 1500, date: DateTime(2023, 08, 30)),
        ],
      ),
      MyPaymentGroup(
        reason: 'project2',
        totalToPay: 1000,
      ),
      MyPaymentGroup(
        reason: 'project3',
        totalToPay: 4000,
        paymentInstances: [
          MyPaymentInstance(amount: 1000, date: DateTime(2023, 09, 1)),
          MyPaymentInstance(amount: 3000, date: DateTime(2023, 09, 15)),
        ],
      ),
    ],
  ),
  MyClient(
    name: 'person2',
    paymentGroups: [
      MyPaymentGroup(reason: 'project4', totalToPay: 0),
    ],
  ),
];

final columns = <ReportColumn>[
  ReportColumn(
    id: MyClient.kname,
    name: 'Client',
  ),
  ReportColumn.nameOnly(
    name: 'payments',
    children: [
      ReportColumn(
        id: MyPaymentGroup.kreason,
        name: 'reason',
      ),
      ReportColumn(
        id: MyPaymentGroup.ktotalToPay,
        name: 'total to pay',
      ),
      ReportColumn.nameOnly(
        name: 'instances',
        children: [
          ReportColumn(
            id: MyPaymentInstance.kdate,
            name: 'date',
          ),
          ReportColumn(
            id: MyPaymentInstance.kamount,
            name: 'amount',
          ),
        ],
      ),
    ],
  ),
];

List<ReportRow> mapDataToRows(
  List<MyClient> clients,
) {
  return clients.map((e) {
    return ReportRow(
      columnAssignments: {
        MyClient.kname: ReportColumnValueAssignment(value: e.name),
      },
      children: e.paymentGroups.map((paymentGroup) {
        return ReportRow(
          columnAssignments: {
            MyPaymentGroup.kreason:
                ReportColumnValueAssignment(value: paymentGroup.reason),
            MyPaymentGroup.ktotalToPay:
                ReportColumnValueAssignment(value: paymentGroup.totalToPay),
          },
          children: paymentGroup.paymentInstances.map((paymentInstance) {
            return ReportRow(
              columnAssignments: {
                MyPaymentInstance.kamount:
                    ReportColumnValueAssignment(value: paymentInstance.amount),
                MyPaymentInstance.kdate:
                    ReportColumnValueAssignment(value: paymentInstance.date),
              },
            );
          }).toList(),
        );
      }).toList(),
    );
  }).toList();
}

void main() {
  group('ReportRange', () {
    test('single', () {
      final range = ReportRange.single(rowIndex: 6, columnIndex: 5);

      expect(range.rowIndex, 6);
      expect(range.rowSpan, 1);
      expect(range.columnIndex, 5);
      expect(range.colSpan, 1);
    });
    test('fromIndexes', () {
      final range = ReportRange.fromIndexes(
        startRowIndex: 5,
        endRowIndex: 6,
        startColumnIndex: 7,
        endColumnIndex: 7,
      );

      expect(range.rowIndex, 5);
      expect(range.rowSpan, 2);
      expect(range.columnIndex, 7);
      expect(range.colSpan, 1);
    });
  });

  test('Calculate header cells golden test', () {
    final golden = <ReportRange, dynamic>{
      ReportRange(
        rowIndex: 0,
        columnIndex: 0,
        rowSpan: 3,
        colSpan: 1,
      ): columns[0].name,
      ReportRange(
        rowIndex: 0,
        columnIndex: 1,
        rowSpan: 1,
        colSpan: 4,
      ): columns[1].name,
      ReportRange(
        rowIndex: 1,
        columnIndex: 1,
        rowSpan: 2,
        colSpan: 1,
      ): columns[1].children[0].name,
      ReportRange(
        rowIndex: 1,
        columnIndex: 2,
        rowSpan: 2,
        colSpan: 1,
      ): columns[1].children[1].name,
      ReportRange(
        rowIndex: 1,
        columnIndex: 3,
        rowSpan: 1,
        colSpan: 2,
      ): columns[1].children[2].name,
      ReportRange(
        rowIndex: 2,
        columnIndex: 3,
        rowSpan: 1,
        colSpan: 1,
      ): columns[1].children[2].children[0].name,
      ReportRange(
        rowIndex: 2,
        columnIndex: 4,
        rowSpan: 1,
        colSpan: 1,
      ): columns[1].children[2].children[1].name,
    };
    const rowOffset = 0;
    const colOffset = 0;
    final cells = TabularReporter.calculateHeaderCells(
      columns: columns,
      offsetColumnIndex: colOffset,
      offsetRowIndex: rowOffset,
    );

    final toCompare = Map.fromEntries(
      cells.map((e) => MapEntry(e.range, e.value)),
    );
    expect(
      toCompare,
      golden.map(
        (key, value) => MapEntry(
          key.shiftRowsBy(rowOffset).shiftColumnsBy(colOffset),
          value,
        ),
      ),
    );
  });
  test('Calculate cells golden test', () {
    final golden = <ReportRange, dynamic>{
      //Client
      ReportRange(
        rowIndex: 0,
        columnIndex: 0,
        rowSpan: 6,
        colSpan: 1,
      ): sampleData[0].name,
      ReportRange.single(
        rowIndex: 6,
        columnIndex: 0,
      ): sampleData[1].name,
      //Reason
      ReportRange(
        rowIndex: 0,
        columnIndex: 1,
        rowSpan: 3,
        colSpan: 1,
      ): sampleData[0].paymentGroups[0].reason,
      ReportRange(
        rowIndex: 3,
        columnIndex: 1,
        rowSpan: 1,
        colSpan: 1,
      ): sampleData[0].paymentGroups[1].reason,
      ReportRange(
        rowIndex: 4,
        columnIndex: 1,
        rowSpan: 2,
        colSpan: 1,
      ): sampleData[0].paymentGroups[2].reason,
      ReportRange.single(
        rowIndex: 6,
        columnIndex: 1,
      ): sampleData[1].paymentGroups[0].reason,
      //Total to pay
      ReportRange(
        rowIndex: 0,
        columnIndex: 2,
        rowSpan: 3,
        colSpan: 1,
      ): sampleData.first.paymentGroups[0].totalToPay,
      ReportRange(
        rowIndex: 3,
        columnIndex: 2,
        rowSpan: 1,
        colSpan: 1,
      ): sampleData.first.paymentGroups[1].totalToPay,
      ReportRange(
        rowIndex: 4,
        columnIndex: 2,
        rowSpan: 2,
        colSpan: 1,
      ): sampleData.first.paymentGroups[2].totalToPay,
      ReportRange.single(
        rowIndex: 6,
        columnIndex: 2,
      ): sampleData[1].paymentGroups[0].totalToPay,
      //Instances date
      ReportRange.single(
        rowIndex: 0,
        columnIndex: 3,
      ): sampleData.first.paymentGroups[0].paymentInstances[0].date,
      ReportRange.single(
        rowIndex: 1,
        columnIndex: 3,
      ): sampleData.first.paymentGroups[0].paymentInstances[1].date,
      ReportRange.single(
        rowIndex: 2,
        columnIndex: 3,
      ): sampleData.first.paymentGroups[0].paymentInstances[2].date,
      ReportRange.single(
        rowIndex: 4,
        columnIndex: 3,
      ): sampleData.first.paymentGroups[2].paymentInstances[0].date,
      ReportRange.single(
        rowIndex: 5,
        columnIndex: 3,
      ): sampleData.first.paymentGroups[2].paymentInstances[1].date,
      //Instances Amount
      ReportRange.single(
        rowIndex: 0,
        columnIndex: 4,
      ): sampleData.first.paymentGroups[0].paymentInstances[0].amount,
      ReportRange.single(
        rowIndex: 1,
        columnIndex: 4,
      ): sampleData.first.paymentGroups[0].paymentInstances[1].amount,
      ReportRange.single(
        rowIndex: 2,
        columnIndex: 4,
      ): sampleData.first.paymentGroups[0].paymentInstances[2].amount,
      ReportRange.single(
        rowIndex: 4,
        columnIndex: 4,
      ): sampleData.first.paymentGroups[2].paymentInstances[0].amount,
      ReportRange.single(
        rowIndex: 5,
        columnIndex: 4,
      ): sampleData.first.paymentGroups[2].paymentInstances[1].amount,
    };

    const rowOffset = 5;
    const colOffset = 3;

    final cells = TabularReporter.calculateCells(
      columns: columns,
      rows: mapDataToRows(sampleData),
      offsetColumnIndex: colOffset,
      offsetRowIndex: rowOffset,
    );

    final toCompare =
        Map.fromEntries(cells.map((e) => MapEntry(e.range, e.value)));
    expect(
      toCompare,
      golden.map(
        (key, value) => MapEntry(
            key.shiftRowsBy(rowOffset).shiftColumnsBy(colOffset), value),
      ),
    );
  });
}
