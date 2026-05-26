enum TransactionType {
  debit,
  credit;

  bool get isDebit => this == TransactionType.debit;
  bool get isCredit => this == TransactionType.credit;
}
