import 'my_payment_group.dart';

class MyClient {
  static const kname = 'name';

  final String name;
  final List<MyPaymentGroup> paymentGroups;

  const MyClient({
    required this.name,
    this.paymentGroups = const [],
  });
}
