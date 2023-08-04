import 'package:_shared/_shared.dart';
import 'package:reporter/reporter.dart';


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
