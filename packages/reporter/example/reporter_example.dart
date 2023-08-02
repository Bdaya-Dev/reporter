import 'package:reporter/reporter.dart';

/// In this example we use a client that has 0 or more payment groups,
/// where each group has 0 or more payment instances.
class MyClient {
  static const kname = 'name';

  final String name;
  final List<MyPaymentGroup> paymentGroups;

  const MyClient({
    required this.name,
    this.paymentGroups = const [],
  });
}

class MyPaymentGroup {
  static const kreason = 'reason';
  static const ktotalToPay = 'totalToPay';

  final String reason;
  final double totalToPay;
  final List<MyPaymentInstance> paymentInstances;

  const MyPaymentGroup({
    required this.reason,
    required this.totalToPay,
    this.paymentInstances = const [],
  });
}

class MyPaymentInstance {
  static const kdate = 'date';
  static const kamount = 'amount';

  final DateTime date;
  final double amount;

  const MyPaymentInstance({
    required this.date,
    required this.amount,
  });
}

/// Define the structure of the columns, note that only the columns with no children
/// will correspond to actual data, this their [id] is enforced.
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

/// This maps the user data to [ReportRow] which contains grouping information about
/// the rows.
List<ReportRow> mapDataToRows(
  List<MyClient> clients,
) {
  return clients.map((client) {
    return ReportRow(
      // Metadata contains an arbitrary map, which might be useful later when generating
      // Excel/Html tables for example.
      metadata: {
        'color': 'green',
        'src': client,
      },
      // columnAssignments are the data that correspond to each column.
      columnAssignments: {
        MyClient.kname: ReportColumnValueAssignment(value: client.name),
      },
      // children represent the nested rows.
      // There is NO limit on the degree of nesting.
      children: client.paymentGroups.map((paymentGroup) {
        return ReportRow(
          columnAssignments: {
            MyPaymentGroup.kreason: ReportColumnValueAssignment(
              value: paymentGroup.reason,
            ),
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
  //The data source, which usually comes from the server.
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
            MyPaymentInstance(amount: 2000, date: DateTime(2023, 09, 15)),
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

  // calculates the cells based on the input rows and columns.
  // These cells can be adapted to different generators,
  // e.g.: excel, pdf, markdown, html, etc...
  final List<ReportCalculatedRange> cells = TabularReporter.calculateCells(
    columns: columns,
    rows: mapDataToRows(sampleData),
    //(default=0) Shift all columns by 1, useful for inserting columns before the table
    offsetColumnIndex: 1,
    //(default=0) Shift all rows by 2, useful for inserting rows before the table
    offsetRowIndex: 2,
  );

  print('Generated Cells: ${cells.length}');
}
