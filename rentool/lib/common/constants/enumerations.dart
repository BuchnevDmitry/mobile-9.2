enum TimeReceivings {
  morning(1),
  afternoon(2);

  const TimeReceivings(this.value);
  final int value;
}

enum Payment {
  cash(1);

  const Payment(this.value);
  final int value;
}

enum ReceivingMethods {
  delivery(1),
  selfPickup(2);

  const ReceivingMethods(this.value);
  final int value;
}

enum Statuses {
  awaitingConfirmation(1),
  awaitingReceipt(2),
  received(3),
  completed(4),
  canceled(5),
  awaitingReturn(6),
  extended(7);

  const Statuses(this.value);
  final int value;
}
