import 'my_payment_instance.dart';

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
