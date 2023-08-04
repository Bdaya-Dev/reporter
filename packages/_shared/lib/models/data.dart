// import 'package:reporter/reporter.dart';

import 'my_client.dart';
import 'my_payment_group.dart';
import 'my_payment_instance.dart';

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
      const MyPaymentGroup(
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
  const MyClient(
    name: 'person2',
    paymentGroups: [
      MyPaymentGroup(reason: 'project4', totalToPay: 0),
    ],
  ),
];

