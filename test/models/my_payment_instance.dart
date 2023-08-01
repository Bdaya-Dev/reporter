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
