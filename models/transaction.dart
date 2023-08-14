class Transaction {
  final String id;
  final String name;
  final double amount;
  final DateTime created;
  Transaction(
      {required this.id,
      required this.name,
      required this.amount,
      required this.created});
}
