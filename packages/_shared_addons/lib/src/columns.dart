import 'package:_shared/_shared.dart';
import 'package:reporter/reporter.dart';

final columns = <ReportColumn>[
  const ReportColumn(
    id: MyClient.kname,
    name: 'Client',
  ),
  const ReportColumn.nameOnly(
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
